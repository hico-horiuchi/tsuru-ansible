require 'spec_helper'

describe cron do
  it { should have_entry("@weekly docker run --name letsencrypt -p #{property['letsencrypt']['port']}:#{property['letsencrypt']['port']} --rm -v /etc/letsencrypt:/etc/letsencrypt -v /var/lib/letsencrypt:/var/lib/letsencrypt quay.io/letsencrypt/letsencrypt renew").with_user('root') }
end
