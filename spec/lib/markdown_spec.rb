require 'rails_helper'

describe Markdowny do
  describe "render_template" do
    it { expect(Markdowny.render_template("# coucou {{ name }}", "name" => "Alex")).to eq("# coucou Alex") }
  end

  describe "markdown2pdf" do
    let(:markdown) { "# Coucou" }
    let(:output_basename) { "tmp/monfichier" }
    it "should return a pdf file" do
      expect(Markdowny.markdown2pdf(output_basename, markdown)).to eq("tmp/monfichier.pdf")
    end
  end
end
