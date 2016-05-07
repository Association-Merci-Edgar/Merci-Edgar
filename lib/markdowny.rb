module Markdowny
  def self.render_template(content, options)
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML)
    template = Liquid::Template.parse(content)
    template.render(options)
  end

  def self.markdown2pdf(output_basename, markdown)
    md_filename = output_basename + ".md"
    config = Gimli.configure { |config| config.file = md_filename; config.output_dir = File.dirname(output_basename) }
    mf = Gimli::MarkupFile.new(write(md_filename, markdown))
    pdf_converter = Gimli::Converter.new([mf], config)
    pdf_converter.convert!
    pdf_converter.output_file
  end

  private
  def self.write(output_filename, content)
    File.open(output_filename,'w') do |file|
      file.write content
    end
    output_filename
  end
end
