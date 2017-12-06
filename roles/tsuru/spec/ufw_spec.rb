require 'spec_helper'

describe command("ufw status | grep #{property['tsuru']['port']}/tcp") do
  its(:stdout) { should match /#{property['tsuru']['port']}\/tcp\s+ALLOW\s+Anywhere/ }
  its(:exit_status) { should eq 0 }
end
