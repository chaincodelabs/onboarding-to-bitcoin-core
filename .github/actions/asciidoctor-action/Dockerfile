FROM ruby:2-alpine

RUN gem install asciidoctor asciidoctor-pdf asciidoctor-diagram rouge

RUN apk add --no-cache \
      chromium \
      nss \
      freetype \
      freetype-dev \
      harfbuzz \
      ca-certificates \
      ttf-freefont \
      nodejs \
      npm \
      bash

RUN mkdir /mermaid

WORKDIR /mermaid

COPY mermaid-package.json package.json
COPY mermaid-package-lock.json package-lock.json

ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true \
    PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium-browser


# --silent because otherwise we get warnings about the tiny package.json we're
# using. We don't really have a named package here, we just want to specify
# some dependencies.
RUN npm install --silent @mermaid-js/mermaid-cli

# Add user so we don't need --no-sandbox.
RUN addgroup -S pptruser && adduser -S -g pptruser pptruser \
    && chown -R pptruser:pptruser /mermaid

RUN /bin/bash -c "echo '{\"args\":[\"--no-sandbox\"]}' > /mermaid/puppeteer-config.json"

ENV PATH /mermaid/node_modules/.bin:/usr/local/bundle/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
