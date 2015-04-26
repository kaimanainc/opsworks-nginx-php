include_recipe 'deploy'

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

# Add Nginx & HHVM to monit
file = Chef::Util::FileEdit.new("/etc/monit/conf.d/opsworks-agent.monitrc")
file.insert_line_if_no_match("# NGINX Monitor", "# NGINX Monitor
check process nginx with pidfile /var/run/nginx.pid
  group www-data
  start program = '/etc/init.d/nginx start'
  stop program  = '/etc/init.d/nginx stop'
  if 2 restarts with 3 cycles then exec '/sbin/shutdown -h now'

# HHVM Monitor
check process hhvm with pidfile /var/run/hhvm/pid
  group hhvm
  start program = '/etc/init.d/hhvm start'
  stop program  = '/etc/init.d/hhvm stop'
  if failed unixsocket /var/run/hhvm/hhvm.sock then restart
  if 2 restarts with 3 cycles then exec '/sbin/shutdown -h now'")
file.write_file

# Restart Monit
service "monit" do
  supports :restart => true, :reload => true
  action :enable
end 
