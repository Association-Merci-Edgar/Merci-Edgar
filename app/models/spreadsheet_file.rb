class SpreadsheetFile
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming
  extend ActiveModel::Translation
  
  validate :max_lines_limit
  def initialize(filename)
    @filename = filename
    if is_csv?
      @csv_path = filename
    else
      @spreadsheet = Roo::Spreadsheet.open(filename)
    end
  end

  def persisted?
    false
  end

  def is_csv?
    File.extname(@filename).downcase == 'csv'
  end

  def to_csv(csv_path = nil)
    unless is_csv?
      csv_path ||= [@filename, ".csv"].join
      @csv_path = csv_path
      @spreadsheet.to_csv(csv_path)
    end
  end
  
  def csv_path
    @csv_path
  end
  
  def first_row
    @spreadsheet.row(@spreadsheet.first_row)
  end
  
  def last_row
    @spreadsheet.row(@spreadsheet.last_row)
  end
  
  def nb_lines
    @nblines ||= File.open(@csv_path) do |io|      
      nblines = io.readlines.size
    end
  end
  
  def max_lines_limit
    if nb_lines > ENV["CSV_IMPORT_MAXLINES_LIMIT"].to_i
      errors.add(:base, :max_lines_exceeded)
    end
  end
end