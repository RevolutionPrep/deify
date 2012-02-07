require 'rails/generators'

module Deify
  class InstallGenerator < Rails::Generators::Base

    source_root File.join(File.dirname(__FILE__), 'templates')

    def manifest
      copy_file "resque.god", "config/god/resque.god"
      copy_file "redis.yml", "config/redis.yml"
      copy_file "resque.rb", "config/initializers/resque.rb"
    end
    
  end
end