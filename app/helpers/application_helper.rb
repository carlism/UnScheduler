module ApplicationHelper
  def title(page_title)
    content_for(:title) { page_title }
  end
  
  
  def linkify(text)
    if text
      text = text.gsub(/\s@(\w+)/, 
        ' <a target="_blank" href="http://twitter.com/\1">@\1</a>') 
      text = text.gsub(/^@(\w+)/, 
        '<a target="_blank" href="http://twitter.com/\1">@\1</a>') 
    end
    text.html_safe
  end
end
