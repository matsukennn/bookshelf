FROM ruby:3.1

RUN apt-get update -qq && apt-get install -y postgresql-client
RUN mkdir /bookshelf
WORKDIR /bookshelf

COPY Gemfile /bookshelf/Gemfile
COPY Gemfile.lock /bookshelf/Gemfile.lock
RUN bundle install
COPY . /bookshelf

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]