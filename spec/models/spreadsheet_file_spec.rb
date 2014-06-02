require 'spec_helper'
#require 'fakefs'
#require 'fakefs/spec_helpers'

def check_spreadsheet_content(spreadsheet)
  spreadsheet.first_row.should include("code postal")
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
  let(:big_xls_path) { spreadsheet_samples_path('scene_100.xls') }
  let(:invalid_xls_path) { spreadsheet_samples_path('pdf.xls')}
  let(:us_csv_path) { spreadsheet_samples_path('scene_5_us.csv')}
  
  let(:ods_path) { spreadsheet_samples_path('/scene_5.ods') }
  let(:without_nom_path) { spreadsheet_samples_path('/without_nom.csv') }
  let(:csv_path) { spreadsheet_samples_path('/scene_5.csv') }
  
  it "can transform xls file to csv file" do
    subject = SpreadsheetFile.new(xls_path)
    File.exists?(subject.csv_path).should be_true
    check_spreadsheet_content(subject)
  end
  
  it "can transform ods file to csv file" do
    subject = SpreadsheetFile.new(ods_path)
    File.exists?(subject.csv_path).should be_true
    check_spreadsheet_content(subject)
  end

  it "is invalid if not encoded in UTF-8 or ISO-9985-1" do
    subject = SpreadsheetFile.new(us_csv_path)
    subject.should be_invalid
  end


  it 'is invalid if the spreadsheet has more than x rows' do
    subject = SpreadsheetFile.new(big_xls_path)
    # subject.to_csv
    subject.should be_invalid    
  end
  
  it 'is invalid if the spreadsheet is not a real xls file' do
    subject = SpreadsheetFile.new(invalid_xls_path)
    # subject.to_csv
    subject.should be_invalid    
  end

  it 'is invalid if the header spreadsheet does not include nom column' do
    subject = SpreadsheetFile.new(without_nom_path)
    # subject.to_csv
    subject.should be_invalid    
  end
  
end
