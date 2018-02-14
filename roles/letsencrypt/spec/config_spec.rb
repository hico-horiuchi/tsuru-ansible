require 'spec_helper'

%w(/etc/letsencrypt /var/lib/letsencrypt /var/log/letsencrypt).each do |item|
  describe file(item) do
    it { should be_directory }
    it { should be_mode 755 }
    it { should be_owned_by 'root' }
    it { should be_grouped_into 'root' }
  end
end
