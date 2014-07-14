module CarrierWaveDirect
  class FormBuilder < ActionView::Helpers::FormBuilder
    def file_field(method, options = {})
      options.merge!(:name => "file")
      fields = required_base_fields
      fields << content_type_field(options)
      fields << success_action_field(options)
      
      idf = [object_name, method.to_s].join("_")
      options[:style] ||= 'display:none;'

      button = @template.content_tag(:div, class: 'input-append') do 
        @template.tag(:input, id: "pbox_#{idf}", class: 'string input-medium', :style => "display:none", type: 'text') +
        @template.content_tag(:a, I18n.t('helpers.browse'), class: 'btn btn-secondary', onclick: "$('input[id=#{idf}]').click();")
      end

      script = @template.content_tag(:script, type: 'text/javascript') do
        "$('input[id=#{idf}]').change(function() { s = $(this).val(); $('#pbox_#{idf}').val(s.slice(s.lastIndexOf('\\\\')+1));$('#pbox_#{idf}').show(); $('input[type=\"submit\"]').attr('disabled',s == \"\") });".html_safe
      end

      fields << super + button + script
    end
  end
end