# Set initial image
FROM kozhin/ruby:latest

# Set maintainer and image indo
LABEL Description="This image contains Ruby on Rails and NodeJS framework" \
      Vendor="CodedRed" \
      Version="1.0" \
      Maintainer="Konstantin Kozhin <konstantin@codedred.com>"

# Install necessary packages
RUN apt-get update && apt-get install libsqlite3-dev -y \
 && curl -sL https://deb.nodesource.com/setup_10.x | bash - \
 && apt-get update && apt-get install nodejs -y

# Install Yarn as it is required for Ruby on Rails with Webpacker
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
 && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
 && apt-get update && apt-get install yarn -y \
 && yarn global add npm@latest \
 && apt-get clean all

# Set environment variables
ENV RAILS_VERSION 5.2.0

# Install Ruby on Rails and some gems
RUN bash -c "source ~/.bash_profile \
 && gem install rails -v $RAILS_VERSION \
 && rbenv rehash"

# Clean up tmp folder
RUN rm -Rf /tmp/*

# Set command
CMD ["bash"]
