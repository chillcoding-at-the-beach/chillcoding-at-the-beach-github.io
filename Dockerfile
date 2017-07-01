FROM ruby:2.3
LABEL maintainer "Rémy Coutable <remy@chillcoding.com>"

WORKDIR /home/site

COPY ./Gemfile* ./

RUN bundle install

COPY ./ ./

# Make port 4000 available to the world outside this container
EXPOSE 4000

CMD ["bundle", "exec", "jekyll", "serve", "--watch", "--future", "--drafts", "--verbose", "--incremental", "--profile", "--trace", "--host", "0.0.0.0"]
