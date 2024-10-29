module ApplicationHelper
  def page_header(text)
    content_tag :h1, text, class: 'text-2xl font-bold text-sky-900 mb-5'
  end

  def primary_button_classes
    'bg-sky-900 hover:bg-sky-700 text-white font-bold py-2 px-4 rounded focus:outline-none focus:shadow-outline'
  end
end
