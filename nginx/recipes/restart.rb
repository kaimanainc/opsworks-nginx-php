 template "/etc/nginx/sites-enabled/default" do
    source "site.erb"
  end
  
  

  
  service "nginx" do
  service_name "nginx"
  supports :start => true, :stop => true, :restart => true, :reload => true
  action [ :restart ]
end
