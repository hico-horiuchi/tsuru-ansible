require 'spec_helper'

describe command("tsuru target-list | grep default") do
  its(:stdout) { should match /^\* default \(https:\/\/#{ENV['TARGET_HSOT']}:#{property['tsuru']['port']}\)$/ }
  its(:exit_status) { should eq 0 }
end

describe command('tsuru user-info') do
  its(:stdout) { should match /^Email: #{property['tsuru']['root']['email']}$/ }
  its(:exit_status) { should eq 0 }
end

describe command('tsuru team-list | grep admin') do
  its(:exit_status) { should eq 0 }
end

property['tsuru']['roles'].each do |item|
  describe command("tsuru role-list | grep #{item['name']}") do
    its(:stdout) { should match /^\|\s+#{item['name']}\s+\|\s+#{item['context']}\s+\|\s+.+\s+\|$/ }
    its(:exit_status) { should eq 0 }
  end

  describe command("tsuru role-default-list | grep #{item['name']}"), if: item['default'] do
    its(:stdout) { should match /^\|\s+#{item['default']}\s+\|\s+.+\s+\|\s+#{item['name']}\s+\|$/ }
    its(:exit_status) { should eq 0 }
  end
end

property['tsuru']['platforms'].each do |item|
  describe command("tsuru platform-list | grep #{item}") do
    its(:stdout) { should match /^- #{item}$/ }
    its(:exit_status) { should eq 0 }
  end
end
