FROM ruby:2.5

# QEMU to target ARM / raspi
COPY qemu-arm-static /usr/bin/qemu-arm-static

RUN apt-get update -qq && apt-get install -y --no-install-recommends nodejs postgresql-client && apt-get -q clean && rm -rf /var/lib/apt/lists && mkdir -p /usr/src/app

WORKDIR /usr/src/app
COPY Gemfile* /usr/src/app/ 
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh && bundle install
COPY . . 

ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]
