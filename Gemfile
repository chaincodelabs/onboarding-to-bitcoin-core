source 'https://rubygems.org'

## If you update the version here, also update it in .travis.yml, .ruby-version,
## and README.md. Then push your branch and make sure Travis supports that
## version.
ruby '3.2.2'

## If you add a new Gem below, run `bundle install` to install it.
group :development do
  gem "jekyll", "~> 4.3.2"
  gem "just-the-docs"
  gem 'jekyll-redirect-from'
  # Lock `http_parser.rb` gem to `v0.6.x` on JRuby builds since newer versions of the gem
  # do not have a Java counterpart.
  #gem "http_parser.rb", "~> 0.6.0", :platforms => [:jruby]
end

group :jekyll_plugins do
  gem "jekyll-feed", "~> 0.12"
  gem "jekyll-asciidoc", "~> 3.0.0"
  gem "asciidoctor-diagram"
  gem "asciidoctor-pdf"
  gem 'rouge'
end

group :testing do
  gem 'html-proofer'
  gem 'mdl'
  gem 'json-schema'
  gem 'toml'
end
