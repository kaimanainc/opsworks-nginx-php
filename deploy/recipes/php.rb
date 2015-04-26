include_recipe 'deploy'
#include_recipe "mod_php5_apache2"
#include_recipe "mod_php5_apache2::php"

Chef::Log.debug("Running deploy/recipes/php.rb")

# run the deploy without reconfiguring the virtual hosts and not restarting the Apache
node[:deploy].each do |application, deploy|
  if deploy[:application_type] != 'php'
    Chef::Log.debug("Skipping deploy::php application #{application} as it is not an PHP app")
    next
  end

  opsworks_deploy_dir do
    user deploy[:user]
    group deploy[:group]
    path deploy[:deploy_to]
  end

  opsworks_deploy do
    deploy_data deploy
    app application
  end
end

 file = Chef::Util::FileEdit.new("/etc/monit/conf.d/opsworks-agent.monitrc")
 file.insert_line_if_no_match('# NGINX Monitor", "# NGINX Monitor
check process nginx with pidfile /var/run/nginx.pid
  start program = "/etc/init.d/nginx start"
  stop program  = "/etc/init.d/nginx stop"
  group www-data # (for ubuntu, debian)

# HHVM Monitor
check process hhvm with pidfile /var/run/hhvm/pid
  group hhvm
  start program = "/etc/init.d/hhvm start"
  stop program  = "/etc/init.d/hhvm stop"
  if failed unixsocket /var/run/hhvm/hhvm.sock then restart
  if 5 restarts with 5 cycles then timeout')
file.write_file
