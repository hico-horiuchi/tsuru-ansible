require 'spec_helper'

describe package('gandalf-server') do
  it { should be_installed }
end

describe service('gandalf-server') do
  it { should be_enabled }
  it { should be_running }
end
