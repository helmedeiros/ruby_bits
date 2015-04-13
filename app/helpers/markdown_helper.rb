require 'redcarpet'
require 'rouge'
require 'rouge/plugins/redcarpet'

module MarkdownHelper
  class RougeHTML < Redcarpet::Render::HTML
    include Rouge::Plugins::Redcarpet
  end

  RENDERER = Redcarpet::Markdown.new(
    RougeHTML.new(filter_html: true, hard_wrap: true, link_attributes: { rel: 'noopener' }),
    fenced_code_blocks: true, tables: true, autolink: true, strikethrough: true,
    superscript: true, no_intra_emphasis: true
  )

  def markdown(text)
    return ''.html_safe if text.blank?
    RENDERER.render(text).html_safe
  end
end
