default['php-fpm']['conf_dir'] = "/etc/php-fpm.d"
default['php-fpm']['conf_file'] = "/etc/php-fpm.conf"
default['php-fpm']['pid'] = "/var/run/php-fpm/php-fpm.pid"
default['php-fpm']['error_log'] =  "/var/log/php-fpm/error.log"
default['php-fpm']['log_level'] = "notice"
default['php-fpm']['emergency_restart_threshold'] = 10
default['php-fpm']['emergency_restart_interval'] = "1m"
default['php-fpm']['process_control_timeout'] = "10s"


default['php-fpm']['pools'] = ["www"]

default['php-fpm']['pool']['www']['listen'] = "127.0.0.1:9000"
default['php-fpm']['pool']['www']['allowed_clients'] = ["127.0.0.1"]
default['php-fpm']['pool']['www']['user'] = "nginx"
default['php-fpm']['pool']['www']['group'] = "nginx""
default['php-fpm']['pool']['www']['process_manager'] = "dynamic"
default['php-fpm']['pool']['www']['max_children'] = 4096
default['php-fpm']['pool']['www']['start_servers'] = 20
default['php-fpm']['pool']['www']['min_spare_servers'] = 5
default['php-fpm']['pool']['www']['max_spare_servers'] = 128
default['php-fpm']['pool']['www']['max_requests'] = 20
default['php-fpm']['pool']['www']['request_terminate_timeout'] = "30s"
