require 'spec_helper'

describe file('/mnt/data/mariadb') do
  it { should be_directory }
  it { should be_mode 755 }
end
