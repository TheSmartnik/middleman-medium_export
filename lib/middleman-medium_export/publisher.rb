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
    updated_html = article.local_images.inject(article.html) do |html, image|
      response = api_client.upload_image(image: File.open(image.location))
      url = response['data']['url'] # it may contain errors  {"errors"=>[{"message"=>"Token was invalid.", "code"=>6003}]}
      html.gsub(image.src, url)
    end

    api_client.publish(content: updated_html, tags: article.tags, title: article.title)
  end
end
