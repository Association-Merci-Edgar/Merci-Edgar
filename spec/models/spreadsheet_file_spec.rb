require "rails_helper"
require "tempfile"

describe SpreadsheetFile do

  it "truthy with a authorized encoded file" do
    file = Tempfile.new("fakefile")
    File.open(file, 'w') { |f| f.puts "something strange" }
    spreadsheet = SpreadsheetFile.new(file.path)
    expect(spreadsheet.readable?).to be_truthy
  end

  it "falsy with a unauthorized (binary) encoded file" do
    file = Tempfile.new("fakefile")
    spreadsheet = SpreadsheetFile.new(file.path)
    expect(spreadsheet.readable?).to be_falsy
  end

end

