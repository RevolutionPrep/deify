# Put this file in config/initializers to control how resque and resque-pubsub are run

rails_root = ENV['RAILS_ROOT'] || File.dirname(__FILE__) + '/../..'
rails_env = ENV['RAILS_ENV'] || 'development'

require 'resque'
require 'resque/failure/base'
require 'resque/failure/redis'
require 'resque/failure/airbrake'
require 'resque/failure/multiple'
Resque::Failure::Multiple.classes = [Resque::Failure::Redis, Resque::Failure::Airbrake]
Resque::Failure.backend = Resque::Failure::Multiple

REDIS_CONFIG = YAML.load_file(rails_root + '/config/redis.yml')[rails_env]
Resque.redis = REDIS_CONFIG["host"] + ':' + REDIS_CONFIG["port"].to_s

# Replace 'your_app_name' below with the actual name of the application, or some other namespace if you desire
Resque.redis.namespace = rails_env=='test' ? 'resque:test_your_app_name' : 'resque:your_app_name'
