require 'middleman-medium_export/content'

class MediumExport::ContentBuilder

  attr_reader :articles, :template

  def initialize(articles:, template:)
    @articles = articles
    @template = template
  end

  def call
    articles.map do |article|
      MediumExport::Content.new(article: article, template: template)
    end
  end
end
