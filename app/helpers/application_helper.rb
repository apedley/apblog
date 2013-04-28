module ApplicationHelper

  def full_title(page_title)
    base_title = "Andrew Pedley"
    if page_title.empty?
      base_title
    else
      "#{page_title} | #{base_title}"
    end
  end

  def tag_cloud(tags, classes)
    max = tags.sort_by(&:count).last
    tags.each do |tag|
      index = tag.count.to_f / max.count * (classes.size - 1)
      yield(tag, classes[index.round])
    end
  end

  def tag_list
    Tag.used
  end

  class HTMLwithPygments < Redcarpet::Render::HTML
    def block_code(code, language)
      Pygments.highlight(code, :lexer => language)
    end
  end

  def markdown(text)
    renderer = HTMLwithPygments.new(:hard_wrap => true)
    options = {
      :fenced_code_blocks => true,
      :no_intra_emphasis => true,
      :autolink => true,
      :strikethrough => true,
      :lax_html_blocks => true,
      :superscript => true
    }
    Redcarpet::Markdown.new(renderer, options).render(text).html_safe
  end

  def preview(html)
    r = Random.rand(30..120) + 540
    truncate_html(html, length: r, omission: '...(cont)')
  end

end
