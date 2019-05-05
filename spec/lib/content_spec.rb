# frozen_string_literal: true

require 'middleman-medium_export/extension'
require 'middleman-medium_export/content'
require 'middleman-medium_export/template'

RSpec.describe MediumExport::Content do
  let(:article) { double( body: body, blog_data: double(controller: double(app: app))) }
  let(:app) do
    double(
      source_dir: 'source',
      generic_template_context: double(render: rendered_template)
    )
  end
  let(:rendered_template) { '' }
  let(:template) { nil }

  subject(:content) { described_class.new(article: article, template: template) }

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

  describe '#html' do
    let(:template) do
      MediumExport::Template.new(template_path: '', template_position: position)
    end

    let(:rendered_template) { '<h1>example disclaimer</h1>' }
    let(:body) { '<h1> My article </h1>' }

    subject(:html) { content.html }

    context 'when template position is top' do
      let(:position) { 'top' }

      it { expect(html).to eq('<h1>example disclaimer</h1><h1> My article </h1>') }
    end

    context 'when template position is top' do
      let(:position) { 'bottom' }

      it { expect(html).to eq('<h1> My article </h1><h1>example disclaimer</h1>') }
    end
  end
end
