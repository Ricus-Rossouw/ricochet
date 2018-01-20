# Using latest version of Ruby
FROM 'ruby:2.5.0'

# UBUNTU Install
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev

# Node.js
RUN curl -sL https://deb.nodesource.com/setup_9.x | bash - \
&& apt-get install -y nodejs

# YARN
RUN apt-get update && apt-get install -y curl apt-transport-https wget && \
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
apt-get update && apt-get install -y yarn

# Creating App directories
RUN mkdir /ricochetapp
WORKDIR /ricochetapp

# Create Gemfiles to bundle
ADD Gemfile /ricochetapp/Gemfile
ADD Gemfile.lock /ricochetapp/Gemfile.lock

RUN bundle install
ADD . /ricochetapp
