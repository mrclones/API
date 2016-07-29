FROM ruby:latest
MAINTAINER Marek Onderko <marek.onderko@t-systems.sk>

# Set environment variable
ENV APP_HOME /app

# Update OS and install build-essential
RUN apt-get update -qq && apt-get install -y build-essential


# Make directory /app, /app/users, /app/spaces and set it as work directory
RUN mkdir $APP_HOME
RUN mkdir "$APP_HOME/users"
RUN mkdir "$APP_HOME/spaces"
WORKDIR $APP_HOME

# Add Gemfile and install Sinatra
ADD Gemfile* $APP_HOME/
RUN bundle install

# Add main.rb
ADD . $APP_HOME

# Expose port 8443
EXPOSE 8443

# Run main.rb
CMD ["/usr/local/bin/ruby","main.rb"]
