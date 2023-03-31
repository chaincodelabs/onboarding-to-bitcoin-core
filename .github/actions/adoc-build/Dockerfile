# asciidoctor image
FROM asciidoctor/docker-asciidoctor
RUN apk --update add imagemagick
RUN gem install asciidoctor-diagram
RUN apk --update add npm
RUN set -x \
    && apk update \
    && apk upgrade \
    && apk add --no-cache \
    chromium \
    && npm install puppeteer
RUN npm install -g @mermaid-js/mermaid-cli

# Set the Puppeteer executable path
ENV PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium-browser
ENV MERMAID_CONFIG_FILE=/mermaid-config.json

# Copy the Mermaid configuration file to the container
RUN wget https://raw.githubusercontent.com/chaincodelabs/onboarding-to-bitcoin-core/master/mermaid-config.json -O /mermaid-config.json

LABEL "version"="1.0"

# Setup entrypoint
COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

