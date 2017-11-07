#!/bin/bash
git pull
bundle install
bundle exec rake assets:precompile db:migrate RAILS_ENV=production
sudo apachectl restart
