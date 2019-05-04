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
      template ? article.body : article.body # fix
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
    @images ||= Nokogiri.parse(html).css('img').map do |img|
      src = img.attributes['src'].value
      next if src.start_with?('http')

      Image.new(src, File.join(source_dir, src))
    end.compact
  end

  private

  def source_dir
    article.blog_data.controller.app.source_dir
  end
end
