require 'rails'

module Deify

  class Engine < Rails::Engine

    generators do
      require File.dirname(__FILE__) + '/../generators/install_generator.rb'
    end

  end

end