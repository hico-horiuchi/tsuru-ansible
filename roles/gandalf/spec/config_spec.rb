require 'spec_helper'

describe file('/home/git/bare-template/hooks') do
  it { should be_directory }
  it { should be_mode 755 }
  it { should be_owned_by 'git' }
  it { should be_grouped_into 'git' }
end

describe file('/home/git/bare-template/hooks/pre-receive') do
  it { should be_file }
  it { should be_mode 755 }
  it { should be_owned_by 'git' }
  it { should be_grouped_into 'git' }
end

describe file('/etc/gandalf.conf') do
  it { should be_file }
  it { should contain "url: 127.0.0.1:#{property['mongo']['port']}" }
  it { should contain "host: #{ENV['TARGET_HOST']}" }
  it { should contain "bind: 127.0.0.1:#{property['gandalf']['port']}" }
  it { should be_mode 644 }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
end

describe port(property['gandalf']['port']) do
  it { should be_listening.on('127.0.0.1').with('tcp') }
end
