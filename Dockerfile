# Set initial image
FROM kozhin/ruby:latest

# Set maintainer and image indo
LABEL Description="This image contains Ruby on Rails framework" \
      Vendor="CodedRed" \
      Version="1.0" \
      Maintainer="Konstantin Kozhin <konstantin@codedred.com>"

# Install necessary packages
RUN apt-get update && apt-get install libsqlite3-dev -y

# Install the latest NodeJS and npm as it is required for Ruby on Rails 5.1+
RUN curl -sL https://deb.nodesource.com/setup_9.x | bash -
RUN apt-get update && apt-get install nodejs -y

# Install Yarn as it is required for Ruby on Rails with Webpacker
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update && apt-get install yarn -y

# Update npm to the latest
RUN yarn global add npm@latest

# Clean up
RUN apt-get clean all

# Set environment variables
ENV RAILS_VERSION 5.2.0

# Install Ruby on Rails and some gems
RUN bash -c "source ~/.bash_profile \
 && gem install rails -v $RAILS_VERSION \
 && rbenv rehash"

# Clean up tmp folder
RUN rm -Rf /tmp/*

# Set entrypoint
ENTRYPOINT ["bash"]
