module ApplicationHelper

  def title(title)
    @title = title
  end

  def show_title
    title  = @title ? "#{@title} - " : ''
    title += 'My Podcasts'
    content_tag :title, title
  end

  def description(text)
    @description = text
  end

  def show_description
    tag('meta', name: 'description', content: @description) if @description
  end
end
