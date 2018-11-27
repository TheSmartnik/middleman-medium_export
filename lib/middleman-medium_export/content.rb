class MediumExport::Content

  attr_reader :article, :template

  def initialize(article:, template:)
    @article = article
    @template = template
  end

  def html
    @content ||= begin
      template ? article.body : article.body # fix
    end
  end

  def markdown
    File.read(article.source_file)
  end

  def title
    article.title
  end

  def tags
    article.tags
  end
end
