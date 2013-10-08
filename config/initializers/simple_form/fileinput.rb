module SimpleForm
  module Inputs
    class FileInput < Base
      def input
        idf = "#{lookup_model_names.join("_")}_#{reflection_or_attribute_name}"
        input_html_options[:style] ||= 'display:none;'

        button = template.content_tag(:div, class: 'input-append') do 
          template.tag(:input, id: "pbox_#{idf}", class: 'string input-medium', :style => "display:none", type: 'text') +
          template.content_tag(:a, I18n.t('helpers.browse'), class: 'btn btn-secondary', onclick: "$('input[id=#{idf}]').click();")
        end

        script = template.content_tag(:script, type: 'text/javascript') do
          "$('input[id=#{idf}]').change(function() { s = $(this).val(); $('#pbox_#{idf}').val(s.slice(s.lastIndexOf('\\\\')+1));$('#pbox_#{idf}').show() });".html_safe
        end

        @builder.file_field(attribute_name, input_html_options) + button + script
      end
    end
  end
end