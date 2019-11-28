FROM ruby:2.6.3

WORKDIR /

COPY Gemfile Gemfile
COPY Gemfile.lock Gemfile.lock

RUN bundle install

COPY . /

EXPOSE 3000

CMD ["bundle", "exec", "rails", "server", "-b","0.0.0.0"]
