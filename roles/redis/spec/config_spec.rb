require 'spec_helper'

describe file('/var/lib/redis') do
  it { should be_directory }
  it { should be_mode 755 }
  it { should be_grouped_into 'root' }
end
