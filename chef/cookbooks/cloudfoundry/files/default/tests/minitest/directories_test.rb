require File.expand_path('../support/helpers', __FILE__)

describe 'cloudfoundry::directories' do
  include Helpers::Cloudfoundry

  it 'creates a config_dir' do
    directory('/etc/cloudfoundry').must_exist.with(:owner, 'cloudfoundry')
  end

  it 'creates a data_dir' do
    directory('/var/vcap/data').must_exist.with(:owner, 'cloudfoundry')
  end

  it 'creates a log_dir' do
    directory('/var/log/cloudfoundry').must_exist.with(:owner, 'cloudfoundry')
  end

  it 'creates a pid_dir' do
    directory('/var/run/cloudfoundry').must_exist.with(:owner, 'cloudfoundry')
  end
end
