require 'spec_helper'

describe docker_container('api') do
  its(['HostConfig.NetworkMode']) { should eq 'host' }
  its(['HostConfig.RestartPolicy.Name']) { should eq 'always' }
  its(['HostConfig.RestartPolicy.MaximumRetryCount']) { should eq 0 }
  its(['Config.Image']) { should eq "tsuru/api:#{property['tsuru']['version']}" }
  it { should exist }
  it { should be_running }
  it { should have_volume('/etc/tsuru', '/etc/tsuru/tsuru') }
end

describe port(property['tsuru']['port']) do
  it { should be_listening.on('::').with('tcp6') }
end
