working_directory "/var/www/forestapp"

pid "/var/www/forestapp/tmp/pids/unicorn.pid"

stderr_path "/var/www/forestapp/log/unicorn.log"
stdout_path "/var/www/forestapp/log/unicorn.log"

listen “/tmp/unicorn.shop.sock”
worker_processes 2
timeout 30