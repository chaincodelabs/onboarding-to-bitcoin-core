FROM quay.io/official-images/debian 
RUN bash -c "echo cache buster 22"
RUN bash -c "apt update"
RUN apt --yes upgrade
RUN apt --yes install build-essential curl procps git
RUN gpg --keyserver keyserver.ubuntu.com --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
RUN \curl -sSL https://get.rvm.io/ | bash -s stable
#RUN /bin/bash -l -c ". /etc/profile.d/rvm.sh && rvm install 2.6.4 && rvm use 2.6.4"
RUN bash -l -c "rvm install 3.2.2"
RUN bash -l -c "rvm use 3.2.2"
WORKDIR /srv/
ENV PATH /usr/local/rvm/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
RUN bash -l -c "gem install http_parser.rb -v '0.8.0' --source 'https://rubygems.org/'"
RUN bash -l -c "gem install bundler --source 'https://rubygems.org/'"
RUN bash -l -c "gem install bundle --source 'https://rubygems.org/'"
RUN bash -l -c "bundle install"
ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8
ENTRYPOINT bash -l
