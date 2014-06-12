class SpreadsheetFile
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming
  extend ActiveModel::Translation
  
  validates :nb_lines, numericality: { only_integer:true, less_than: ENV["CSV_IMPORT_MAXLINES_LIMIT"].to_i }
  validates :encoding, inclusion: { in: %w(utf-8 iso-8859-1)}
  validates :readable, inclusion: { in: [ true ] }
  validates :is_csv?, inclusion: { in: [ true ] }
  validates :name_header_exist, inclusion: { in: [ true ] }
  validates :kind, inclusion: { in: %w(venue festival show_buyer structure person) }
  
  attr_reader :kind
  
  def initialize(filename, kind = "venue")
    @filename = filename
    @kind = kind
  end

  def persisted?
    false
  end

  def kind_klass
    @kind_klass ||= Object.const_get(kind.camelize)
  end

  def csv_path
    @csv_path ||= to_csv if readable
  end
  
  def first_row
    File.open(csv_path) do |io|
      first_line = io.gets
      first_line.parse_csv.map(&:downcase)
    end if readable
  end
  
  def last_row
    @spreadsheet.row(@spreadsheet.last_row)
  end
  
  def nb_lines
    @nblines ||= File.open(csv_path) do |io|      
      nblines = io.readlines.size
    end if readable
  end
  
  def encoding
    return @encoding if @encoding
    if readable
      m = Mimer.identify(csv_path).mime_type
      @encoding = m.match(/charset=(.*);?/)[1]
    else
      @encoding = false
    end
  end
  
  private
  def name_header_exist
    first_row.include?("nom") if readable
  end
    
  def readable
    return @readable if @readable != nil
    if is_csv?
      @readable = true
    else
      begin
        @spreadsheet ||= Roo::Spreadsheet.open(@filename)
        @readable = true
      rescue Ole::Storage::FormatError
        @readable = false
      end
    end
  end

  def is_csv?
    File.extname(@filename).downcase == '.csv'
  end

  def to_csv(csv_path = nil)
    return @filename if is_csv?
    csv_path = [@filename, ".csv"].join
    @spreadsheet.to_csv(csv_path) if readable
    csv_path
  end
  
end