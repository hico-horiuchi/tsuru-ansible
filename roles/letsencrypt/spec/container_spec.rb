require 'spec_helper'

%w(fullchain.pem privkey.pem).each do |item| 
  describe file("/etc/letsencrypt/live/#{ENV['TARGET_HOST']}/#{item}") do
    it { should be_symlink }
    it { should be_owned_by 'root' }
    it { should be_grouped_into 'root' }
  end
end
