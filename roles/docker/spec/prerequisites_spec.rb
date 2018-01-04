require 'spec_helper'

UBUNTU_RELEASE_CODE_NAME = { '16.04' => 'xenial' }.freeze

%w(apt-transport-https ca-certificates curl software-properties-common).each do |item|
  describe package(item) do
     it { should be_installed }
  end
end

describe command('apt-key list | grep docker') do
  its(:stdout) { should contain 'Docker Release \(CE deb\)' }
  its(:exit_status) { should eq 0 }
end

describe file('/etc/apt/sources.list.d/download_docker_com_linux_ubuntu.list') do
  it { should be_file }
  it { should contain "deb [arch=amd64] https://download.docker.com/linux/ubuntu #{UBUNTU_RELEASE_CODE_NAME[host_inventory['platform_version']]} stable" }
  it { should be_mode 644 }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
end
