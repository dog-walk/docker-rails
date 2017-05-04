# Set initial image
FROM kozhin/ruby:latest

# Set maintainer and image indo
MAINTAINER Konstantin Kozhin <konstantin@profitco.ru>
LABEL Description="This image contains Ruby on Rails framework" Vendor="ProfitCo" Version="1.0"

# Install NodeJS as it is required for Ruby on Rails 5.1+
RUN curl -sL https://deb.nodesource.com/setup_7.x | sudo -E bash -
RUN apt-get install -y nodejs

# Clean up package repositories
RUN apt-get clean all

# Set environment variables
ENV RAILS_VERSION 5.1.0

# Install Ruby on Rails and some gems
RUN bash -c "source ~/.bash_profile \
 && gem install rails -v $RAILS_VERSION \
 && rbenv rehash"

# Clean up tmp folder
RUN rm -Rf /tmp/*

# Set entrypoint
ENTRYPOINT ["bash"]
