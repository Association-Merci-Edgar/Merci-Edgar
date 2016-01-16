require "rails_helper"

describe ExportContacts do

  describe "perform" do
    it { expect(ExportContacts).to respond_to(:perform_async) }
  end

end
