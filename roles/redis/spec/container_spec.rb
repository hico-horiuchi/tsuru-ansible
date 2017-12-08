require 'spec_helper'

describe docker_container('redis') do
  its(['HostConfig.LogConfig.Type']) { should eq 'journald' }
  its(['HostConfig.PortBindings.6379/tcp']) { should eq [{ 'HostIp' => property['redis']['host'], 'HostPort' => property['redis']['port'].to_s }] }
  its(['HostConfig.RestartPolicy.Name']) { should eq 'always' }
  its(['HostConfig.RestartPolicy.MaximumRetryCount']) { should eq 0 }
  it { should exist }
  it { should be_running }
  it { should have_volume('/data', '/var/lib/redis') }
end

describe port(property['redis']['port']) do
  it { should be_listening.on(property['redis']['host']).with('tcp') }
end
