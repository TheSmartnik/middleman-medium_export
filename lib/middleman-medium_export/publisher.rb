class MediumExport::Publisher
  attr_reader :content, :shell, :api_client

  def initialize(content:, shell:, api_client:)
    @content = content
    @shell = shell
    @api_client = api_client
  end

  def call
    shell.say("Preparing to publish #{content.size} articles") if content.size > 1

    content.each do |article|
      publish(article)
      shell.say(%Q(Published: "#{article.title}"), :green)
    end
  end

  private

  def publish(article)
    api_client.publish(content: article.html, tags: article.tags, title: article.title)
  end
end
