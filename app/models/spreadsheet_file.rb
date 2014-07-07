class SpreadsheetFile
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming
  extend ActiveModel::Translation
  
  validates :readable?, inclusion: { in: [ true ] }
  validates :nb_lines, numericality: { only_integer:true, less_than: ENV["CSV_IMPORT_MAXLINES_LIMIT"].to_i, allow_nil: true }, if: :readable?
  # validates :is_csv?, inclusion: { in: [ true ] }
  validates :name_header_exist, inclusion: { in: [ true ] }, if: :readable?
  validates :kind, inclusion: { in: %w(venue festival show_buyer structure person) }
  
  attr_reader :kind
  
  ACCEPTED_ENCODINGS = %w(utf-8 iso-8859-1 us-ascii utf-16le)
  COMMON_DELIMITERS = [',', ';', "\t"]
  COMMON_DELIMITERS_WITH_DOUBLE_QUOTES = ['","', '";"', "\"\t\""]
  
  def col_sep
    return @col_sep if @col_sep.present?
    File.open(csv_path, "r:#{file_encoding}") do |io|
      first_line = io.gets
      return nil unless first_line
      snif = {}
      COMMON_DELIMITERS.each_with_index do |delim, index|
        quote_delim = COMMON_DELIMITERS_WITH_DOUBLE_QUOTES[index]
        snif[delim]=first_line.count(quote_delim)
      end
      snif = snif.sort {|a,b| b[1]<=>a[1]}
      @col_sep = snif.size > 0 ? snif[0][0] : nil
    end
  end
  
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
    @csv_path ||= to_csv
  end
  
  def first_row
    local_col_sep = col_sep
    File.open(csv_path, "r:#{file_encoding}") do |io|
      first_line = io.gets
      first_line.parse_csv(col_sep: local_col_sep).map{|k| k.try(:downcase)}
    end if readable?
  end
  
  def last_row
    @spreadsheet.row(@spreadsheet.last_row)
  end
  
  def nb_lines
    @nblines ||= %x{wc -l < #{csv_path}}.to_i if readable?
  end
  
  def encoding
    return @encoding if @encoding
    m = Mimer.identify(csv_path).mime_type
    @encoding = m.match(/charset=(.*);?/)[1]
  end
  
  def file_encoding
    @file_encoding ||= encoding.start_with?("utf") ? "bom|#{encoding}" : encoding if encoding 
  end
  
  def well_encoded?
    ACCEPTED_ENCODINGS.include?(encoding)
  end
  
  
  def name_header_exist
    first_row.include?("nom") if readable?
  end
    
  def readable?
    return @readable if @readable != nil
    @readable = false
    
    @readable = true if is_csv? && well_encoded?
    unless is_csv?
      begin
        @spreadsheet ||= Roo::Spreadsheet.open(@filename)
        @col_sep = ','
        @readable = true
      rescue Ole::Storage::FormatError
        @readable = false
      end
    end
    return @readable
  end

  def is_csv?
    File.extname(@filename).downcase == '.csv' || File.extname(@filename).downcase == '.txt'
  end

  def to_csv(csv_path = nil)
    return @filename if is_csv?
    if self.class.xls_allowed?
      @csv_path = [@filename, ".csv"].join
      @spreadsheet.to_csv(@csv_path,nil,col_sep) if readable?
      @encoding = Encoding.find("internal").to_s.downcase
      @csv_path
    end
  end
  
  def self.xls_allowed?
    ENV["XLS_ALLOWED"].to_bool
  end
  
end