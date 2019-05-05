Feature: CLI Commands
  Scenario: Trying to export article without api token specified
    Given a fixture app "blog-app"
    And a file named "config.rb" with:
      """
      activate :medium_export do |export|
        export.api_token = ''
      end
      """
    When I run `middleman medium_export`
    Then the output should contain "MediumExport::ApiTokenMissing"

  @debug @wip
  Scenario: Trying to export article with api token specified
      Given a fixture app "blog-app"
      And a file named "config.rb" with:
        """
        require 'middleman-blog'

        activate :blog
        activate :medium_export do |export|
          export.api_token = 'Bla Bla Bla'
        end
        """
      When I run `middleman medium_export`
      Then the output should contain ""

  @debug @wip
  Scenario: Trying to export article with disclaimer attached
      Given a fixture app "blog-app"
      And a file named "config.rb" with:
        """
        require 'middleman-blog'

        activate :blog
        activate :medium_export do |export|
          export.api_token = 'Bla Bla Bla'
          export.template_path = '_disclaimer_template'
        end
        """
      When I run `middleman medium_export`
      Then the output should contain "Something"
