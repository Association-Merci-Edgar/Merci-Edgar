require 'spec_helper'
#require 'fakefs'
#require 'fakefs/spec_helpers'

def check_spreadsheet_content(spreadsheet)
  spreadsheet.first_row.should include("CODE POSTAL")
  spreadsheet.last_row.should include("La tannerie")      
end

describe SpreadsheetFile do
 # include FakeFS::SpecHelpers

  before(:each) do
    FileUtils.mkdir_p(test_tmp_path)
  end
  
  after(:each) do
    FileUtils.rm_rf(test_tmp_path)
  end
  
  let(:xls_path) { spreadsheet_samples_path('scene_5.xls') }
  let(:big_xls_path) { spreadsheet_samples_path('scene_2600.xls') }
  let(:invalid_xls_path) { spreadsheet_samples_path('pdf.xls')}
  let(:ods_path) { spreadsheet_samples_path('/scene_5.ods') }
  let(:csv_path) { spreadsheet_samples_path('/scene_5.csv') }
  
  it "can transform xls file to csv file" do
    subject = SpreadsheetFile.new(xls_path)
    subject.to_csv
    File.exists?(subject.csv_path).should be_true
    check_spreadsheet_content(subject)
  end
  
  it "can transform ods file to csv file" do
    subject = SpreadsheetFile.new(ods_path)
    subject.to_csv
    File.exists?(subject.csv_path).should be_true
    check_spreadsheet_content(subject)
  end

  it "can read an xls file not encoded in UTF-8"
  it "can detect a malformed spreadsheet file"
  it "can detect an invalid spreadsheet file" do
    expect { SpreadsheetFile.new(invalid_xls_path) }.to raise_error
  end
  
  it 'is invalid if the spreadsheet has more than x rows' do
    subject = SpreadsheetFile.new(big_xls_path)
    subject.to_csv
    subject.should be_invalid    
  end
end
