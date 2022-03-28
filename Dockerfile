FROM ruby:3.0.0

ADD https://dl.yarnpkg.com/debian/pubkey.gpg /tmp/yarn-pubkey.gpg
RUN apt-key add /tmp/yarn-pubkey.gpg && rm /tmp/yarn-pubkey.gpg
RUN echo 'deb http://dl.yarnpkg.com/debian/ stable main' > /etc/apt/sources.list.d/yarn.list

RUN apt-get update && apt-get install -qq -y --no-install-recommends \
      build-essential libpq-dev curl
RUN curl -sL https://deb.nodesource.com/setup_6.x | bash -
RUN apt-get update && apt-get install -qq -y --no-install-recommends nodejs yarn

ENV WORK_ROOT /src
ENV APP_HOME $WORK_ROOT/rails_api_base/
ENV LANG C.UTF-8
ENV GEM_HOME $WORK_ROOT/bundle
ENV BUNDLE_BIN $GEM_HOME/gems/bin
ENV PATH $GEM_HOME/bin:$BUNDLE_BIN:$PATH

RUN gem install bundler

RUN mkdir -p $APP_HOME

RUN bundle config --path=$GEM_HOME

WORKDIR $APP_HOME

ADD Gemfile ./
ADD Gemfile.lock ./
RUN bundle install

ADD package.json yarn.lock ./
RUN yarn install --ignore-engines

ADD . $APP_HOME

EXPOSE 3000

ENTRYPOINT [ "bundle", "exec" ]
