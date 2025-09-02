FROM docker.io/library/ruby:3.2.2-alpine

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

# Install correct bundler version
RUN gem install bundler -v 2.7.1

WORKDIR /srv

EXPOSE 4000

CMD ["bundle", "exec", "jekyll", "serve", "--host", "0.0.0.0", "--future", "--drafts", "--unpublished", "--incremental"]
