require 'spec_helper'

describe docker_container('mongo') do
  its(['HostConfig.LogConfig.Type']) { should eq 'journald' }
  its(['HostConfig.PortBindings.27017/tcp']) { should eq [{ 'HostIp' => property['mongo']['host'], 'HostPort' => property['mongo']['port'].to_s }] }
  its(['HostConfig.RestartPolicy.Name']) { should eq 'always' }
  its(['HostConfig.RestartPolicy.MaximumRetryCount']) { should eq 0 }
  it { should exist }
  it { should be_running }
  it { should have_volume('/data/db', '/var/lib/mongo') }
end

describe port(property['mongo']['port']) do
  it { should be_listening.on(property['mongo']['host']).with('tcp') }
end
