require 'spec_helper'

describe cron do
  it { should have_entry("@weekly docker run --log-driver journald --name letsencrypt -p #{property['letsencrypt']['port']}:#{property['letsencrypt']['port']} --rm -v /etc/letsencrypt:/etc/letsencrypt -v /var/lib/letsencrypt:/var/lib/letsencrypt certbot/certbot renew").with_user('root') }
end
