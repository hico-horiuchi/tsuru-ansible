describe docker_container('registry') do
  its(['HostConfig.PortBindings.5000/tcp']) { should eq [{ 'HostIp' => property['docker_registry']['host'], 'HostPort' => property['docker_registry']['port'].to_s }] }
  its(['HostConfig.RestartPolicy.Name']) { should eq 'always' }
  its(['HostConfig.RestartPolicy.MaximumRetryCount']) { should eq 0 }
  its(['Config.Env']) { should include 'REGISTRY_STORAGE_FILESYSTEM_ROOTDIRECTORY=/var/lib/registry' }
  it { should exist }
  it { should be_running }
  it { should have_volume('/var/lib/registry', '/var/lib/registry') }
end

describe port(property['docker_registry']['port']) do
  it { should be_listening.on(property['docker_registry']['host']).with('tcp') }
end
