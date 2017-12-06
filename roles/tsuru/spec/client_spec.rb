require 'spec_helper'

describe file('/usr/local/bin/tsuru') do
  it { should be_file }
  it { should be_mode 775 }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
end

describe command('tsuru version') do
  its(:stdout) { should match /^tsuru version #{property['tsuru']['version'].gsub(/^v/, '')}./ }
  its(:exit_status) { should eq 0 }
end
