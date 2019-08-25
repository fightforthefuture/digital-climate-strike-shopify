FROM ruby:2.6.1-alpine AS development

WORKDIR /usr/src

ENV HOME=/usr/src PATH=/usr/src/bin:$PATH

RUN apk add --no-cache \
  build-base \
  ca-certificates \
  chromium \
  chromium-chromedriver \
  libpq \
  postgresql-dev \
  git \
  less \
  nodejs \
  npm \
  openssl \
  sqlite-dev \
  su-exec \
  tzdata \
  yarn

RUN npm config set unsafe-perm true

RUN npm install -g check-dependencies

ADD Gemfile* /usr/src/

RUN bundle install --jobs=4 --retry=3

RUN yarn install

ARG DEVELOPER_UID="1000"
ARG DEVELOPER_USER="you"

RUN adduser -H -D -h /usr/src -u $DEVELOPER_UID $DEVELOPER_USER \
 && addgroup $DEVELOPER_USER root

ENV DEVELOPER_USER=$DEVELOPER_USER

CMD [ "bundle", "console" ]


FROM development AS dummy

ENV PATH=/usr/src/spec/dummy/bin:$PATH


FROM development AS testing

ADD . /usr/src
