FROM ruby:2.3.1

RUN mkdir -p /tmp/src
COPY . /tmp/src
WORKDIR /tmp/src
RUN bundle install
RUN rake generate

RUN mkdir -p /var/www/app
COPY ./public /var/www/app
WORKDIR /var/www/app

EXPOSE 8000

CMD ruby -run -ehttpd . -p8000
