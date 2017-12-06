require 'ansible/vault'
require 'ansible_spec'
require 'net/ssh'
require 'serverspec'
require 'yaml'

RSpec.configure do |config|
  config.color = true
  config.tty = true
  config.formatter = :documentation
end

host = ENV['TARGET_HOST']
hosts = ENV['TARGET_HOSTS']
group_idx = ENV['TARGET_GROUP_INDEX'].to_i

options = Net::SSH::Config.for(host)
options[:user] ||= ENV['TARGET_USER']
options[:port] ||= ENV['TARGET_PORT']
options[:keys] ||= ENV['TARGET_PRIVATE_KEY']

set :backend,     :ssh
set :host,        options[:host_name] || host
set :ssh_options, options

vars = {}
property = AnsibleSpec.get_properties[group_idx]
ansible_cfg = File.expand_path('../ansible.cfg', File.dirname(__FILE__))
vault_password_file = ''
vault_password = ''

property['roles'].each do |role|
  main = "roles/#{role}/defaults/main.yml"
  if File.exist?(main)
    vars.deep_merge! YAML.load_file(main)
  end
end

vars.deep_merge! AnsibleSpec.get_variables(host, group_idx, hosts)

File.open(ansible_cfg, 'r') do |f|
  vault_password_file = f.read.match(/^vault_password_file = (.+)$/)[1]
end

File.open(File.expand_path(vault_password_file), 'r') do |f|
  vault_password = f.read.chomp
end

Dir.glob("group_vars/*/secret.yml").each do |secret|
  if File.exist?(secret)
    vars.deep_merge! YAML.load(Ansible::Vault.read(path: secret, password: vault_password))
  end
end

set_property vars
