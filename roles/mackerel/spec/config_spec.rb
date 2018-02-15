require 'spec_helper'

describe file('/etc/mackerel-agent/conf.d') do
  it { should be_directory }
  it { should be_mode 755 }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
end

describe file('/etc/mackerel-agent/mackerel-agent.conf') do
  it { should be_file }
  it { should contain "apikey = \"#{property['mackerel']['apikey']}\"" }
  it { should contain "display_name = \"#{ENV['TARGET_HOST']}\"" }
  it { should be_mode 644 }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
end

property['mackerel']['plugins'].each do |item|
  describe file("/etc/mackerel-agent/conf.d/#{item}.conf") do
    it { should be_file }
    it { should contain "[plugin.metrics.#{item}]" }
    it { should contain "/usr/local/bin/mackerel-plugin-#{item}" }
    it { should be_mode 644 }
    it { should be_owned_by 'root' }
    it { should be_grouped_into 'root' }
  end
end
