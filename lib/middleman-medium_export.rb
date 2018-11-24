require "middleman-core"

Middleman::Extensions.register :middleman-medium_export do
  require "my-extension/extension"
  MyExtension
end
