require 'spec_helper'

describe file('/etc/tsuru') do
  it { should be_directory }
  it { should be_mode 755 }
  it { should be_grouped_into 'root' }
end

describe file('/etc/tsuru/tsuru.conf') do
  it { should be_file }
  it { should contain "listen: \"#{property['tsuru']['host']}:#{property['tsuru']['port']}\"" }
  it { should contain "host: http://#{ENV['TARGET_HOST']}:#{property['tsuru']['port']}" }
  it { should contain "units-per-app: #{property['tsuru']['quota']['units']}" }
  it { should contain "apps-per-user: #{property['tsuru']['quota']['apps']}" }
  it { should be_mode 644 }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
end
