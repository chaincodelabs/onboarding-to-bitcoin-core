FROM docker.io/library/ruby:3.3.8-alpine

# Install system dependencies
RUN apk add --no-cache \
    build-base \
    git \
    nodejs \
    npm \
    chromium \
    make

# Set chromium path for puppeteer (needed for mermaid diagrams)
ENV PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium

# Install latest bundler version
RUN gem install bundler

# Install mermaid-cli globally
RUN npm install -g @mermaid-js/mermaid-cli

WORKDIR /srv

# Copy dependency files first for better caching
COPY Gemfile Gemfile.lock package*.json ./

# Install dependencies
RUN bundle install && npm install

# Ensure bundle bin is in PATH
ENV PATH="/usr/local/bundle/bin:$PATH"

EXPOSE 4000

CMD ["sh", "-c", "bundle install && bundle exec jekyll serve --host 0.0.0.0 --future --drafts --unpublished --incremental --force_polling"]
