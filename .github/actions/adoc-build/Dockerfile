# asciidoctor image
FROM asciidoctor/docker-asciidoctor
RUN apk --update add imagemagick
RUN gem install asciidoctor-diagram

LABEL "version"="1.0"

# Setup entrypoint
COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

