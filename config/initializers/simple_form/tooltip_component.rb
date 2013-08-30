module SimpleForm
  module Components
    module Tooltip
      def tooltip
        if has_tooltip?
          tooltip = options[:tooltip]
          tooltip_content = tooltip.is_a?(String) ? tooltip : translate(:tooltips)
          tooltip_content.html_safe if tooltip_content

          template.content_tag(:a, href:"#", :"data-toggle" => "tooltip", :"title" => tooltip_content, :"data-placement" => tooltip_position) do
            template.content_tag(:i, '', :class => 'entypo edi-help')
          end
        end
      end
      def tooltip_position
        "left"
      end
      def has_tooltip?
        options[:tooltip].present?
      end
    end
  end
end

SimpleForm::Inputs::Base.send(:include, SimpleForm::Components::Tooltip)