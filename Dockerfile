FROM ruby:3.2.2-slim-bookworm

RUN apt update && \
    apt --yes upgrade && \
    apt --yes install build-essential curl procps git \
        fonts-liberation libasound2 \
        libatk-bridge2.0-0 libatk1.0-0 libc6 libcairo2 libcups2 libdbus-1-3 libexpat1 \
        libfontconfig1 libgbm1 libgcc1 libgtk-3-0 libnspr4 libnss3 libpango-1.0-0 \
        libpangocairo-1.0-0 libstdc++6 libx11-6 libx11-xcb1 libxcb1 libxcomposite1 libxcursor1 \
        libxdamage1 libxext6 libxfixes3 libxi6 libxrandr2 libxrender1 libxss1 libxtst6 \
        --no-install-recommends && \
    rm -rf /var/lib/apt/lists/*

ARG UID=1000
ARG GID=1000

WORKDIR /srv/
COPY Gemfile /srv/Gemfile

RUN groupadd -g ${GID} docs && \
    useradd -m -u ${UID} -g docs -s /bin/bash docs
RUN chown -R docs:docs /srv/
USER docs

RUN bash -l -c "echo 'export GEM_HOME=${HOME}/.gem' >> ${HOME}/.bashrc \
 && echo 'export GEM_PATH=${HOME}/.gem' >> ${HOME}/.bashrc \
 && source ~/.bashrc \
 && bundle config set --local path ${HOME}/.gem \
 && bundle install"

RUN bash -l -c "curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.5/install.sh | bash \
 && export NVM_DIR=\"\$([ -z \"${XDG_CONFIG_HOME-}\" ] && printf %s \"${HOME}/.nvm\" || printf %s \"${XDG_CONFIG_HOME}/nvm\")\" \
 && [ -s \"\$NVM_DIR/nvm.sh\" ] && \\. \"\$NVM_DIR/nvm.sh\" \
 && echo 'export PATH=${PATH}:/srv/node_modules/.bin' >> ${HOME}/.bashrc \
 && source ~/.bashrc \
 && nvm install node \
 && npm install @mermaid-js/mermaid-cli"

ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8
ENTRYPOINT ["bash", "-l"]
