# Puma can serve each request in a thread from an internal thread pool.
# The `threads` method setting takes two numbers: a minimum and maximum.
max_threads_count = ENV.fetch('RAILS_MAX_THREADS') { 5 }
min_threads_count = ENV.fetch('RAILS_MIN_THREADS') { max_threads_count }
threads min_threads_count, max_threads_count

# Specifies that the worker count should equal the number of processors.
worker_count = ENV.fetch('WEB_CONCURRENCY') { 0 }
workers worker_count if worker_count > 1

# Specifies the `worker_timeout` for worker boot to prevent slow booting.
worker_timeout 3600 if ENV.fetch('RAILS_ENV', 'development') == 'development'

# Specifies the `port` that Puma will listen on to receive requests.
port ENV.fetch('PORT') { 3000 }

# Specifies the `environment` that Puma will run in.
environment ENV.fetch('RAILS_ENV') { 'development' }

# Specifies the `pidfile` that Puma will use.
pidfile ENV.fetch('PIDFILE') { 'tmp/pids/server.pid' }

# Allow puma to be restarted by `bin/rails restart` command.
plugin :tmp_restart
