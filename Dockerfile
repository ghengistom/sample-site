FROM ruby:2.3

ENV RACK_ENV=production
WORKDIR /usr/src/app
COPY . /usr/src/app

RUN bundle install --without development:test -j4 --deployment \
    && bundle exec rake assets:precompile

EXPOSE 3000

ENTRYPOINT ["bundle", "exec"]
CMD ["puma", "-C", "config/puma.rb"]
