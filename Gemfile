source 'https://rubygems.org'

## If you update the version here, also update it in Docker and GitHub Actions
ruby '4.0.1'

gem "asciidoctor", "~>2.0.23"
gem "rouge", "~> 4.4"
gem "csv", "~> 3.3"
gem "base64", "~> 0.2"

## If you add a new Gem below, run `bundle install` to install it.
group :development do
  gem "jekyll", "~> 4.3.4"
  gem "just-the-docs", "~> 0.10"
  gem 'jekyll-redirect-from', '~> 0.16'
  # Lock `http_parser.rb` gem to `v0.6.x` on JRuby builds since newer versions of the gem
  # do not have a Java counterpart.
  #gem "http_parser.rb", "~> 0.6.0", :platforms => [:jruby]
end

group :jekyll_plugins do
  gem "asciidoctor-diagram", "~> 2.3"
  gem "jekyll-feed", "~> 0.17"
  gem "jekyll-asciidoc", "~> 3.0.1"
end

group :asciidoc_plugins do
  gem "asciidoctor-epub3", "~> 2.1"
  gem "asciidoctor-pdf", "~> 2.3"
  gem "rubyzip", "~> 2.3.0"
end

group :testing do
  gem 'html-proofer', '~> 5.0'
  gem 'mdl', '~> 0.13'
  gem 'json-schema', '~> 5.0'
  gem 'toml', '~> 0.3'
end
