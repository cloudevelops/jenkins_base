#!/usr/bin/env ruby

require 'redis'
require 'rubygems'
require 'getopt/long'
require 'yaml'
require 'json'

opt = Getopt::Long.getopts(
	["--promotion_environment", "-e", Getopt::REQUIRED],
	["--package_organization", "-o", Getopt::REQUIRED],
	["--package_name", "-n", Getopt::REQUIRED],
	["--package_version", "-v", Getopt::OPTIONAL],
	["--package_iteration", "-i", Getopt::REQUIRED],
	["--git_branch", "-b", Getopt::REQUIRED],
	["--git_hash", "-gh", Getopt::REQUIRED],
	["--checkout_build_number", "-bn", Getopt::REQUIRED]
)

if !opt["promotion_environment"]
	puts "Environment is empty"
end

if !opt["package_organization"] 
	puts "Organization is empty"
end

if !opt["package_name"]
	puts "Package name is empty"
end

if !opt["package_version"]
	puts "Package version is empty"
end

if !opt["package_iteration"]
	puts "Package iteration is empty"
end
if !opt["git_branch"]
	puts "Git branch is empty"
end
if !opt["git_hash"]
	puts "Git hash is empty"
end
if !opt["checkout_build_number"]
	puts "Checkout build number is empty"
end

promotion_environment = opt["promotion_environment"]
package_organization = opt["package_organization"]
package_name = opt["package_name"]
package_version = opt["package_version"]
package_iteration = opt["package_iteration"]
git_branch = opt["git_branch"]
git_hash = opt["git_hash"]
checkout_build_number = opt["checkout_build_number"]

redis = Redis.new(host: "217.28.94.40", password: "J206CPFGJu1KA4wt")

puts "Updating version"
redis.set("#{promotion_environment}/modules/#{package_organization}_hiera/common/#{package_organization}::application::#{package_name}::version", "#{package_version}-#{package_iteration}-#{checkout_build_number}-#{git_hash}")

puts "Updating branch"
redis.set("#{promotion_environment}/modules/#{package_organization}_hiera/common/#{package_organization}::application::#{package_name}::branch", "#{git_branch}")

puts "Updating artefact"
redis.set("#{promotion_environment}/modules/#{package_organization}_hiera/common/#{package_organization}::application::#{package_name}::artefact", "#{package_name}-#{package_organization}")

puts "Checkout build number"
redis.set("#{promotion_environment}/modules/#{package_organization}_hiera/common/#{package_organization}::application::#{package_name}::build", "#{checkout_build_number}")


roles_json = redis.get("#{promotion_environment}/modules/#{package_organization}_hiera/common/#{package_organization}::application::#{package_name}::role")
roles = JSON.parse(roles_json)
puts "Roles:"
ansible_role_array = []
roles.each do | key,value |
  ansible_role_array.push(key)
  puts key
end
ansible_role = ansible_role_array.join(':')

puts "Stopping puppet on hosts"
stop_puppet = "sudo -u ansible -i -- sh -c 'ansible -i /etc/ansible/#{promotion_environment} #{ansible_role} --sudo --forks 10 -m shell -a \"service puppet stop; rm -f /var/lib/puppet/state/agent_catalog_run.lock\"'"
puts stop_puppet
puts `#{stop_puppet}`

puts "Updating repository cache"
update_repository_cache = "sudo -u ansible -i -- sh -c 'ansible -i /etc/ansible/#{promotion_environment} #{ansible_role} --sudo --forks 10 -m shell -a '\"'\"'apt-get update -o Dir::Etc::sourcelist=\"sources.list.d/#{package_organization}-deploy.list\" -o Dir::Etc::sourceparts=\"-\" -o APT::Get::List-Cleanup=\"0\"'\"'\"''"
puts update_repository_cache
puts `#{update_repository_cache}`

puts "Install package"
install_package = "sudo -u ansible -i -- sh -c 'ansible -i /etc/ansible/#{promotion_environment} #{ansible_role} --sudo --forks 10 -m shell -a \"apt-get install -y --force-yes #{package_name}-#{package_organization}=#{package_version}-#{package_iteration}-#{checkout_build_number}-#{git_hash}\"'"
puts install_package
puts `#{install_package}`

puts "Run puppet"
run_puppet = "sudo -u ansible -i -- sh -c 'ansible -i /etc/ansible/#{promotion_environment} #{ansible_role} --sudo --forks 10 -m shell -a \"puppet agent -t\"'"
puts run_puppet
puts `#{run_puppet}`

exit 0
