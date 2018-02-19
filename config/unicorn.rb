current_path = '/var/www/capistrano_exercise/current'
shared_path = '/var/www/capistrano_exercise/shared'

worker_processes 2

working_directory current_path

listen "#{shared_path}/tmp/sockets/unicorn.sock", backlog: 64
listen 8080, tcp_nopush: true
pid "#{shared_path}/tmp/pids/unicorn.pid"

timeout 30

stderr_path "#{shared_path}/log/unicorn.stderr.log"
stdout_path "#{shared_path}/log/unicorn.stdout.log"

preload_app true

check_client_connection false

run_once = true

before_fork do |server, worker|
  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.connection.disconnect!

  if run_once
    run_once = false
  end

  old_pid = "#{server.config[:pid]}.oldbin"
  if old_pid != server.pid
    begin
      sig = (worker.nr + 1) >= server.worker_processes ? :QUIT : :TTOU
      Process.kill(sig, File.read(old_pid).to_i)
    rescue Errno::ENOENT, Errno::ESRCH
    end
  end

  sleep 1
end

after_fork do |server, worker|
  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.establish_connection
end

before_exec do |server|
  ENV['BUNDLE_GEMFILE'] = "#{current_path}/Gemfile"
end
