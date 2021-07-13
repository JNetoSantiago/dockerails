FROM ruby:3.0.2

ENV project=dockerails

RUN apt update -qq && apt -y install \
    autoconf \
    bison \
    build-essential \
    libssl-dev \
    libyaml-dev \
    libreadline6-dev \
    zlib1g-dev \
    libncurses5-dev \
    libffi-dev \
    libgdbm-dev \
    git-core \
    curl

#Install NodeJS, npm and Yarn
RUN curl -sL https://deb.nodesource.com/setup_14.x | bash - && \
	apt install -y nodejs && \
	curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
	echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
	apt -y update && apt -y install yarn

RUN apt-get clean && rm -rf /var/lib/apt/list/*

WORKDIR /${project}

COPY Gemfile Gemfile.lock ./
COPY Makefile /${project}/Makefile

RUN bundle install

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]
