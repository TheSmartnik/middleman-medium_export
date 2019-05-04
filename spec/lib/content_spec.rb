# frozen_string_literal: true
# frozen_string_literal: true

require 'middleman-medium_export/extension'
require 'middleman-medium_export/content'

RSpec.describe MediumExport::Content do
  let(:article) do
    double(
      body: body,
      blog_data: double(controller: double(app: double(source_dir: 'source')))
    )
  end
  subject(:content) do
    described_class.new(article: article)
  end

  describe '#local_images' do
    let(:body) do
      <<~STR
        <img src="/images/images/profile.jpg" alt="Profile" />
        <img src="https://example.com" alt="Profile" />
        <img src="http://example.com" alt="Profile" />
      STR
    end

    specify do
      images = content.local_images
      expect(images.size).to eq 1
      expect(images.first.src).to eq('/images/images/profile.jpg')
      expect(images.first.location).to eq('source/images/images/profile.jpg')
    end
  end
end
