require 'spec_helper'

describe command("ufw status | grep #{property['letsencrypt']['port']}/tcp") do
  its(:stdout) { should match /#{property['letsencrypt']['port']}\/tcp\s+ALLOW\s+Anywhere/ }
  its(:exit_status) { should eq 0 }
end
