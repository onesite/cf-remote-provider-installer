require File.expand_path('../support/helpers', __FILE__)

describe 'cloudfoundry::user' do
  include Helpers::Cloudfoundry

  it 'creates a user' do
    user('cloudfoundry').must_exist
  end

  it "creates a user with the expected uid" do
    user('cloudfoundry').must_have(:uid, node['cloudfoundry']['uid'])
  end

  it "creates a user with the expected gid" do
    user('cloudfoundry').must_have(:gid, node['cloudfoundry']['gid'])
  end

  it "creates a user with the expected home" do
    user('cloudfoundry').must_exist.with(:home, '/home/cloudfoundry')
  end

  it "creates a group" do
    group('cloudfoundry').must_exist
  end
end
