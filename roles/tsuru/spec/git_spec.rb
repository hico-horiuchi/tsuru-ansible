require 'spec_helper'

describe file('/home/git/.bash_profile') do
  it { should be_file }
  its(:content) { should match /^export TSURU_TOKEN=[a-z0-9]{40}$/ }
  it { should contain "export TSURU_HOST=127.0.0.1:#{property['tsuru']['port']}" }
  it { should be_mode 644 }
  it { should be_owned_by 'git' }
  it { should be_grouped_into 'git' }
end
