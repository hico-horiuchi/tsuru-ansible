require 'spec_helper'

describe command("ufw status | grep #{property['planb']['port']}/tcp") do
  its(:stdout) { should match /#{property['planb']['port']}\/tcp\s+ALLOW\s+Anywhere/ }
  its(:exit_status) { should eq 0 }
end
