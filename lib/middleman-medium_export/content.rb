require 'nokogiri'

class MediumExport::Content
  Image = Struct.new(:src, :location)

  attr_reader :article, :template

  def initialize(article:, template: nil)
    @article = article
    @template = template
  end

  def html
    @content ||= begin
      template ? body_with_template : article.body
    end
  end

  def markdown
    @markdown ||= File.read(article.source_file)
  end

  def title
    article.title
  end

  def tags
    article.tags
  end

  def local_images
    @images ||= Nokogiri::HTML(html).search('img').map do |img|
      src = img.attributes['src'].value
      next if src.start_with?('http')

      Image.new(src, File.join(source_dir, src))
    end.compact
  end

  private

  def body_with_template
    template_html = template_context.render(nil, template.path, { locals: {}})
    template.position == :top ? "#{template_html}#{article.body}" : "#{article.body}#{template_html}"
  end

  def source_dir
    @source_dir ||= app.source_dir
  end

  def template_context
    @template_context ||= app.generic_template_context
  end

  def app
    @app ||= article.blog_data.controller.app
  end
end
