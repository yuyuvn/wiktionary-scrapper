FROM ruby

ENV LANG C.UTF-8

RUN cp /usr/share/zoneinfo/Asia/Tokyo /etc/localtime
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash -
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list


RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        build-essential \
        nodejs \
        yarn \
        vim \
    && rm -rf /var/lib/apt/lists/*

RUN gem install bundler

RUN mkdir /app
WORKDIR /app
ADD Gemfile /app/Gemfile
ADD Gemfile.lock /app/Gemfile.lock
ADD scrapper.rb /app/scrapper.rb

RUN bundle install --jobs=4
ADD . /app
