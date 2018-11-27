class MediumExport::ArticlesFilter
  attr_reader :articles, :shell

  def initialize(articles:, shell:)
    @articles = articles
    @shell = shell
  end

  def last
    [articles.first]
  end

  def all
    articles
  end

  def interactive
    articles.each_with_object([]) do |article, acc|
      case ask_to_include(article.title)
        when 'Y' then acc.push(article)
        when 'S' then acc.push(article) and break(acc)
        when 'Q' then break(acc)
      end
    end
  end

  private

  def ask_to_include(title)
    shell.say(%Q(Do you want to publish "#{title}"\n).freeze)
    shell.say("  Y - yes and continue\n  S - yes and quit".freeze, :green)
    shell.say("  N - no and continue\n  Q - no and quit\n".freeze, :red)

    shell.ask("\n ", :magenta, limited_to: %w(Y S N Q).freeze)
  end
end
