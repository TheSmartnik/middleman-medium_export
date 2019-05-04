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
