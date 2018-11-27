require 'httparty'

class MediumExport::ApiClient
  include HTTParty

  attr_reader :auth, :publish_status

  base_uri 'https://api.medium.com/v1/'

  headers 'Content-Type': 'application/json'
  headers 'Accept': 'application/json'

  # raise_on (400..599).to_a

  def initialize(api_token:, publish_status:)
    @auth = { Authorization: "Bearer #{api_token}" }
    @publish_status = publish_status
  end

  def publish(content:, title:, tags:)
    response = self.class.post(
      "/users/#{id}/posts",
      headers: auth,
      body: {
        "title": title,
        "contentFormat": "html",
        "content": content,
        "tags": tags,
        "publishStatus": publish_status
      }.to_json
    )
  end

  def me
    self.class.get('/me', headers: auth)
  end

  private

  def id
    @id ||= me['data']['id']
  end
end
