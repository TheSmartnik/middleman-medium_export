# Require core library
require 'middleman-core'

# Extension namespace
class MediumExport < ::Middleman::Extension
  option :api_token, true, 'Middleman API Token'
  option :postscriptum_template, false, 'HTML template to append to the end of each article'

  def initialize(app, options_hash={}, &block)
    # Call super to build options from the options_hash
    super

    # Require libraries only when activated
    # require 'necessary/library'

    # set up your extension
    # puts options.my_option
  end
end
