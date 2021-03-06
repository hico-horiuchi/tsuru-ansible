require 'spec_helper'

describe file('/etc/apt/sources.list') do
  it { should be_file }
  it { should contain "deb #{property['apt']['ubuntu']['uri']}" }
  it { should contain property['apt']['ubuntu']['components'].join(' ') }
  it { should be_mode 644 }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
end
