require 'spec_helper'

describe file('/mnt/data/mongo') do
  it { should be_directory }
  it { should be_mode 755 }
  it { should be_grouped_into 'root' }
end
