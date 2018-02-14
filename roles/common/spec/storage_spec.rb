require 'spec_helper'

describe command('sudo mount | grep /dev/vdb') do
  its(:stdout) { should match /\/dev\/vdb on \/mnt\/data type ext4 \(rw,relatime,errors=remount-ro,data=ordered\)/ }
  its(:exit_status) { should eq 0 }
end

describe file('/etc/fstab') do
  it { should be_file }
  it { should contain '/dev/vdb /mnt/data ext4 errors=remount-ro 0 2' }
  it { should be_mode 644 }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
end
