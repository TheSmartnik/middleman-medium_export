class MediumExport::Publisher
  attr_reader :articles, :shell

  def initialize(articles:, shell:)
    @articles = articles
    @shell = shell
  end

  def call
    shell.say("Preparing to publish #{articles.size} articles") if articles.size > 1

    articles.each do |article|
      publish(article)
      shell.say(%Q(Published: "#{article.title}"), :green)
    end
  end

  private

  def notify
  end

  def publish(_)
    sleep(1)
  end
end
