#!/bin/bash
set -e

bundle install

echo "=== STARTING SIDEKIQ ==="
bundle exec sidekiq -C config/sidekiq.yml

