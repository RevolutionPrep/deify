app_name    = 'your_app_name' # This should match the app name in deploy.rb
rails_env   = ENV['RAILS_ENV']  || "production"
rails_root  = ENV['RAILS_ROOT'] || "/var/www/#{app_name}"
rake_cmd    = rails_env != 'development' ? '/opt/ruby_ent/bin/rake' : '/usr/bin/rake'
num_workers = rails_env == 'production' ? 10 : 2

num_workers.times do |num|
  God.watch do |w|
    w.name     = "#{app_name}-resque-#{num}"
    w.group    = "#{app_name}-resque"
    w.interval = 30.seconds
    w.env      = {"QUEUE"=>"*", "RAILS_ENV"=>rails_env}
    w.start    = "#{rake_cmd} -f #{rails_root}/Rakefile environment resque:work"
    w.stop_signal = 'QUIT'
    w.stop_timeout = 60.seconds
    w.log = "#{rails_root}/log/god.log"

    # restart if memory gets too high
    w.transition(:up, :restart) do |on|
      on.condition(:memory_usage) do |c|
        c.above = 350.megabytes
        c.times = 2
      end
    end

    # determine the state on startup
    w.transition(:init, { true => :up, false => :start }) do |on|
      on.condition(:process_running) do |c|
        c.running = true
      end
    end

    # determine when process has finished starting
    w.transition([:start, :restart], :up) do |on|
      on.condition(:process_running) do |c|
        c.running = true
        c.interval = 5.seconds
      end

      # failsafe
      on.condition(:tries) do |c|
        c.times = 5
        c.transition = :start
        c.interval = 5.seconds
      end
    end

    # start if process is not running
    w.transition(:up, :start) do |on|
      on.condition(:process_running) do |c|
        c.running = false
      end
    end
  end
end
