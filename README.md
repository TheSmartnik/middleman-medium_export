# Middleman Medium Export

A Middleman extension that adds a cli command to export your articles to medium

# Getting Started

Add the gem to your gemfile

```ruby
gem "middleman-medium_export"
```

Activate it in your `config.rb`

```ruby
activate :medium_export do |export|
  export.api_token = 'your_api_token'

  # export.template_path = 'path_to_template'
  # export.template_position = :top
  # export.publish_status = :draft
end
```

## Options

Extension provides several options

`api_token` - required, self issued api token to post your articles

`template_path` - optinal, path to partial to add to your article
`template_position` - optional. Position of your template. Possible values are: `:top` and `:bottom`. Default is `:bottom`
`publish_status` - optional. Status of your articles, when they are exported. Possible values are: `public`, `draft`, or `unlisted`. Default is `:draft`

## Export

### Interactivly

To chose article to export interactivlt

```ruby
be middleman medium_export -m interactive
```

### Only last article

```ruby
be middleman medium_export
```

or 

```ruby
be middleman medium_export -m last
```

### All articles

```ruby
be middleman medium_export -m all
```

## Obtaining Api Token

You used to be able to create an `api_token` yourself, but due to increased spam activity from API, this feature is now restricted. You need to email support with request for an API Token. It usually takes from a couple of hours to a day. Visit official [documentaion](https://github.com/Medium/medium-api-docs#22-self-issued-access-tokens) for more info.

# Contribution

Pull requests and issues are very welcome

To create a pull request

* Clone repo
* Run tests to see, that all is fine `be rake test`
* Implement feature
* Add tests

