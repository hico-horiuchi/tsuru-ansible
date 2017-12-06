require 'spec_helper'

describe file('/lib/systemd/system/docker.service') do
  it { should be_file }
  it { should contain "-H tcp://#{property['docker']['host']}:#{property['docker']['port']}" }
  it { should contain "--insecure-registry #{property['docker_registry']['host']}:#{property['docker_registry']['port']}" }
  it { should be_mode 644 }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
end

describe port(property['docker']['port']) do
  it { should be_listening.on(property['docker']['host']) }
end
