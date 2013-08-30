module SimpleForm
  module Components
    module LabelTooltip
      extend ActiveSupport::Concern

      included do
        include SimpleForm::Components::Labels
      end

      def label_tooltip
        if options[:label] != false
          if options[:tooltip].present?
            tooltip = options[:tooltip]
            tooltip_content = tooltip.is_a?(String) ? tooltip : translate(:tooltips)
            tooltip_content.html_safe if tooltip_content
            html = template.content_tag(:a, href:"#", :"data-toggle" => "tooltip", :"title" => tooltip_content) do
              template.content_tag(:i, '', :class => 'entypo edi-help')
            end
          end
          
          if html.present?
            @builder.label(label_target, label_html_options) do
              html += label_text
            end
          else
            html =@builder.label(label_target, label_text, label_html_options)
          end
          html
        end
      end
    end
  end
end
SimpleForm::Inputs::Base.send(:include, SimpleForm::Components::LabelTooltip)