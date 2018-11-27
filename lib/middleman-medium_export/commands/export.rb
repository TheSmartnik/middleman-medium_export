require 'middleman-core/cli'
require 'middleman-medium_export/articles_filter'
require 'middleman-medium_export/content_builder'
require 'middleman-medium_export/publisher'

module Middleman

  module Cli

    ##
    # This class provides an "medium_export" command for the middleman CLI.
    #
    # @usage bundle exec middleman medium_export
    # @usage bundle exec middleman medium_export --help
    # @usage bundle exec middleman medium_export --mode last
    # @usage bundle exec middleman medium_export --mode interactive
    #
    ##
    class Export < ::Thor::Group
      include Thor::Actions
      include Blog::UriTemplates

      check_unknown_options!

      class_option "blog",
        aliases: "-b",
        desc:    "The name of the blog to create the post inside (for multi-blog apps, defaults to the only blog in single-blog apps)"

      class_option "mode",
        aliases: "-m",
        enum: %w[last all interactive],
        default: 'last',
        desc: "Chose which articles should be published"


      def medium_export
        articles = blog.data.articles.sort_by { |a| -a.date.to_i } # test for publishable

        filtered_articles = MediumExport::ArticlesFilter.
          new(articles: articles, shell: shell).
          public_send(options.mode)

        content = MediumExport::ContentBuilder.new(
          articles: filtered_articles, template: export_extension.template).call

        MediumExport::Publisher.new(
          api_client: export_extension.api_client, content: content, shell: shell).call
      end

      private

      def export_extension
        @export_extension ||= app.extensions[:medium_export]
      end

      def app
        @app ||= ::Middleman::Application.new
      end

      def blog
        @blog ||= if options[:blog]
          app.extensions[:blog].find { | k, v | v.options[:name] == options[ :blog ] }.last
        else
          app.extensions[:blog].values.first
        end
      end

      # Add to CLI
      Base.register(self, 'medium_export', 'medium_export [options]', 'Export one or more articles to middleman')
    end
  end
end
