FROM docker.io/library/ruby:3.2.2-slim

# Install system dependencies
RUN apt-get update && apt-get install --yes --no-install-recommends \
    build-essential \
    git \
    nodejs \
    npm \
    chromium \
    make \
    && rm -rf /var/lib/apt/lists/*

# Set chromium path for puppeteer (needed for mermaid diagrams)
ENV PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium

# Install correct bundler version
RUN gem install bundler -v 2.7.1

WORKDIR /srv

EXPOSE 4000

CMD ["bundle", "exec", "jekyll", "serve", "--host", "0.0.0.0", "--future", "--drafts", "--unpublished", "--incremental"]
