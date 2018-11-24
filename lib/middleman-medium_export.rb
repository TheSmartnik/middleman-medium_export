require "middleman-core"

Middleman::Extensions.register :medium_export do
  require "middleman-medium_export/extension"
  require "middleman-medium_export/commands/export"

  MediumExport
end
