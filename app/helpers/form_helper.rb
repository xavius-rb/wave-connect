module FormHelper
  def render_form_errors(resource)
    return unless resource.errors.any?

    content_tag(:div, class: "rounded-md bg-red-50 p-4") do
      content_tag(:div, class: "flex") do
        content_tag(:div, class: "ml-3") do
          concat(content_tag(:h3, "#{pluralize(resource.errors.count, "error")} prohibited this #{resource.class.name.downcase} from being saved:", class: "text-sm font-medium text-red-800"))
          concat(content_tag(:div, class: "mt-2 text-sm text-red-700") do
            content_tag(:ul, class: "list-disc pl-5 space-y-1") do
              safe_join(resource.errors.map { |error| content_tag(:li, error.full_message) })
            end
          end)
        end
      end
    end
  end
end
