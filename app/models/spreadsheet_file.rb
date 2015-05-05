class SpreadsheetFile
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming
  extend ActiveModel::Translation

  CSV_IMPORT_MAXLINES_LIMIT = 10000
  ACCEPTED_ENCODINGS = %w(utf-8 iso-8859-1 us-ascii utf-16le)
  COMMON_DELIMITERS = [',', ';', "\t"]
  COMMON_DELIMITERS_WITH_DOUBLE_QUOTES = ['","', '";"', "\"\t\""]

  attr_reader :kind

  validates :readable?, inclusion: { in: [ true ] }
  validates :nb_lines, numericality: { only_integer:true, less_than: CSV_IMPORT_MAXLINES_LIMIT, allow_nil: true }, if: :readable?
  validates :name_header_exist, inclusion: { in: [ true ] }, if: :readable?
  validates :kind, inclusion: { in: %w(venue festival show_buyer structure person) }

  def initialize(filename, kind = "venue")
    @filename = filename
    @kind = kind
  end

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

  def name_header_exist
    first_row.include?("nom") if readable?
  end

  def readable?
    ACCEPTED_ENCODINGS.include?(encoding)
  end

  def to_csv
    @filename
  end

  def file_encoding
    @file_encoding ||= encoding.start_with?("utf") ? "bom|#{encoding}" : encoding if encoding
  end

  private

  def encoding
    return @encoding if @encoding
    m = Mimer.identify(@filename).mime_type
    @encoding = m.match(/charset=(.*);?/)[1]
  end
end
