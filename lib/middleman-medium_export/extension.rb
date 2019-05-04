# Require core library
require 'middleman-core'

# Extension namespace
class MediumExport < ::Middleman::Extension
  require 'middleman-medium_export/api_client'
  require 'middleman-medium_export/template'

  ApiTokenMissing = Class.new(ArgumentError)
  InvalidTemplatePosition = Class.new(ArgumentError)
  InvalidPublishStatus = Class.new(ArgumentError)

  TEMPLATES_POSSITIONS = %i[bottom top].freeze
  PUBLISH_STATUSES = %i[public draft unlisted].freeze

  option :api_token, nil, 'Medium API Token'
  option :template_path, nil, 'HTML template to append to the end of each article'
  option :template_position, :bottom
  option :publish_status, :draft
  option :tags_field, :tags

  def initialize(app, options_hash={}, &block)
    super

    check_api_token!
    check_template_path!
    check_template_positions!
    check_publish_statuses!
  end

  def api_client
    @api_client ||= ApiClient.new(options.to_h.slice(:api_token, :publish_status))
  end

  def template
    return unless options.template_path

    Template.new(options.to_h.slice(:template_path, :template_position))
  end

  private

  def check_api_token!
    return unless options.api_token.to_s.empty?

    error_msg = "Please, provide an api_token option. To obtain api_token refer to\n" \
      "https://help.medium.com/hc/en-us/articles/213480228-Get-integration-token\n\n"
    raise ApiTokenMissing, error_msg
  end

  def check_template_path!
    return if options.template_path.nil? || File.exists?(options.template_path)

    raise Errno::ENOENT, "Can't find template at #{options.template_path}"
  end

  def check_template_positions!
    return if TEMPLATES_POSSITIONS.include?(options.template_position.to_sym)

    error_msg = "Invalid template_position: #{options.template_position}.\n" \
      "Possible template positions are: #{TEMPLATES_POSSITIONS.join(", ")}\n\n"
    raise InvalidTemplatePosition, error_msg
  end

  def check_publish_statuses!
    return if PUBLISH_STATUSES.include?(options.publish_status.to_sym)

    error_msg = "Invalid publish_status: #{options.publish_status}.\n" \
      "Possible publish statuses are: #{PUBLISH_STATUSES.join(", ")}\n\n"
    raise InvalidPublishStatus, error_msg
  end
end
