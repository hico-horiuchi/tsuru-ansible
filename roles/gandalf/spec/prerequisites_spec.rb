require 'spec_helper'

describe package('gnupg-curl') do
  it { should be_installed }
end

describe command('apt-key list | grep tsuru') do
  its(:stdout) { should contain 'https://packagecloud.io/tsuru/stable' }
  its(:exit_status) { should eq 0 }
end

describe file('/etc/apt/sources.list.d/tsuru.list') do
  it { should be_file }
  it { should contain "deb https://packagecloud.io/tsuru/stable/#{host_inventory['platform']}/" }
  it { should be_mode 644 }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
end
