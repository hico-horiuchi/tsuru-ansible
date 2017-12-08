require 'spec_helper'

describe docker_container('planb') do
  its(['Args']) { should include ":#{property['planb']['port']}" }
  its(['Args']) { should include property['redis']['port'].to_s }
  its(['HostConfig.LogConfig.Type']) { should eq 'journald' }
  its(['HostConfig.NetworkMode']) { should eq 'host' }
  its(['HostConfig.RestartPolicy.Name']) { should eq 'always' }
  its(['HostConfig.RestartPolicy.MaximumRetryCount']) { should eq 0 }
  its(['Config.Image']) { should eq "tsuru/planb:#{property['planb']['version']}" }
  it { should exist }
  it { should be_running }
end

describe port(property['planb']['port']) do
  it { should be_listening.on('::').with('tcp6') }
end
