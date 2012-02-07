Deify
============

A gem that provides a generator to set up god/resque/redis configuration for any Rails app using resque-based gems at Revolution Prep.



Usage / Examples
================

After installing, just type

    rails generate deify:install
    

This will create three files in your Rails app: config/redis.yml, config/initializers/resque.rb, and config/god/resque.god.

* Make sure to set the correct app name in resque.god and namespace in resque.rb.
* The app name in resque.god MUST match the app name in deploy.rb in order for capistrano-git-plugins to work.
* resque.rb can set any namespace that makes sense but they typically defaults to "resque:#{app_name}" and "resque:test_#{app_name}".



Acknowledgements
================

Copyright (c) 2012 Monica McArthur, released under the MIT license.
