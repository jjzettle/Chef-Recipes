#
# Cookbook:: tomcat
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.
package 'java-1.7.0-openjdk-devel'

group 'chef' do
  action :create
end

user 'chef' do
  home '/opt/tomcat'
  group 'chef'
end

remote_file '/tmp/apache-tomcat-8.0.33.tar.gz' do
  source 'http://archive.apache.org/dist/tomcat/tomcat-8/v8.0.33/bin/apache-tomcat-8.0.33.tar.gz'
end

directory '/opt/tomcat' do
  action :create
  recursive true
end

execute 'extract_tomcat' do
  command 'tar xvf apache-tomcat-8.0.33.tar.gz -C /opt/tomcat --strip-components=1'
  cwd '/tmp'
end

execute 'chgrp -R chef /opt/tomcat/conf'

execute 'chmod g+rwx conf' do
  cwd '/opt/tomcat'
end

execute 'chmod g+r conf/*' do
  cwd '/opt/tomcat'
end

execute 'chown -R chef webapps/ work/ temp/ logs/ conf/' do
  cwd '/opt/tomcat'
end

template '/etc/systemd/system/tomcat.service' do
  source 'tomcat.service.erb'
end

execute 'systemctl daemon-reload'

service 'tomcat' do
  action [:start, :enable]
end
