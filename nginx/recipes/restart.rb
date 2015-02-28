 file "/etc/nginx/sites-enabled/default.txt" do
    content "ssh_key"
  end
  
  service "nginx" do
  service_name "nginx"
  supports :start => true, :stop => true, :restart => true, :reload => true
  action [ :restart ]
end
