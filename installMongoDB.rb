file '/etc/yum.repos.d/mongodb-org-3.4.repo' do
owner 'root'
group 'root'
mode '0755'
action :create
end

file '/etc/yum.repos.d/mongodb-org-3.4.repo' do
content '[mongodb-org-3.4]
name=MongoDB Repository
baseurl=https://repo.mongodb.org/yum/redhat/7Server/mongodb-org/3.4/x86_64/
gpgcheck=1
enabled=1
gpgkey=https://www.mongodb.org/static/pgp/server-3.4.asc'
end

package 'mongodb-org'

service 'mongod' do
action [:enable, :start]
end
