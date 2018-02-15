require 'spec_helper'

describe docker_container('mariadb') do
  its(['HostConfig.LogConfig.Type']) { should eq 'journald' }
  its(['HostConfig.PortBindings.3306/tcp']) { should eq [{ 'HostIp' => property['mariadb']['host'], 'HostPort' => property['mariadb']['port'].to_s }] }
  its(['HostConfig.RestartPolicy.Name']) { should eq 'always' }
  its(['HostConfig.RestartPolicy.MaximumRetryCount']) { should eq 0 }
  its(['Config.Env']) { should include "MYSQL_ROOT_PASSWORD=#{property['mariadb']['root']['password']}" }
  it { should exist }
  it { should be_running }
  it { should have_volume('/var/lib/mysql', '/mnt/data/mariadb') }
end

describe port(property['mariadb']['port']) do
  it { should be_listening.on(property['mariadb']['host']).with('tcp') }
end
