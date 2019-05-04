# frozen_string_literal: true

require 'middleman-medium_export/extension'
require 'middleman-medium_export/publisher'

RSpec.describe MediumExport::Publisher do
  describe '#call' do
    let(:shell) { double(say: nil) }
    let(:articles) { [article] }
    let(:api_client) do
      double(
        publish: nil,
        upload_image: { 'data' => { 'url' => 'https://images.medium.com/0*fkfQiTzT7TlUGGyI.png' } }
      )
    end

    let(:article) do
      double(
        title: "Title",
        tags: [],
        html: %Q(<img src="/images/images/profile.jpg" alt="Profile" />\n),
        local_images: [
          double(location: File.absolute_path(__dir__, '../fixtures/profile.jpg'), src: '/images/images/profile.jpg')
        ]
      )
    end

    specify do
      expect(api_client).to receive(:publish)
        .with(
          content: %Q(<img src="https://images.medium.com/0*fkfQiTzT7TlUGGyI.png" alt="Profile" />\n),
          tags: [],
          title: "Title"
        )

      described_class.new(shell: shell, api_client: api_client, content: articles).call
    end
  end
end
