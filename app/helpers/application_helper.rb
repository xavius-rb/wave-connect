module ApplicationHelper
  def nav_link(path, text, options = {})
    active_class = params[:controller] == options[:controller] ? "border-b-2" : ""
    link_to text, path, class: "inline-flex items-center #{active_class} border-indigo-500 px-1 pt-1 text-sm font-medium text-gray-900"
  end

  def home_nav_link
    nav_link(root_path, "Home", controller: "home")
  end
end
