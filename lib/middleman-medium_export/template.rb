class MediumExport::Template

  attr_reader :path, :position

  def initialize(template_path:, template_position:)
    @path = template_path
    @position = template_position
  end
end
