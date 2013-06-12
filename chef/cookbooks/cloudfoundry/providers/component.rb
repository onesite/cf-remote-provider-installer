#
# Cookbook Name:: cloudfoundry
# Provider:: component
#
# Copyright 2012-2013, ZephirWorks
# Copyright 2012, Trotter Cashion
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

include Chef::Mixin::CloudfoundryCommon
include Chef::Mixin::LanguageIncludeRecipe

def initialize(name, run_context=nil)
  super

  # internal
  new_resource.ruby_version(node['cloudfoundry']['ruby_1_9_2_version']) unless new_resource.ruby_version
  new_resource.ruby_path(ruby_bin_path(new_resource.ruby_version)) unless new_resource.ruby_path

  new_resource.component_name("cloudfoundry-#{new_resource.name}") unless new_resource.component_name
  new_resource.config_dir(node['cloudfoundry']['config_dir']) unless new_resource.config_dir
  new_resource.config_file(::File.join(new_resource.config_dir, "#{new_resource.name}.yml")) unless new_resource.config_file
  new_resource.user(node['cloudfoundry']['user']) unless new_resource.user
  new_resource.group(node['cloudfoundry']['group']) unless new_resource.group
  new_resource.user_home(node['cloudfoundry']['home']) unless new_resource.user_home
  new_resource.bin_file(::File.join(new_resource.install_path, "bin", new_resource.name)) unless new_resource.bin_file
  new_resource.binary("#{::File.join(new_resource.ruby_path, "ruby")} #{new_resource.bin_file}")
  new_resource.upstart_file("upstart.conf.erb") unless new_resource.upstart_file
  new_resource.upstart_file_cookbook("cloudfoundry") unless new_resource.upstart_file_cookbook

  service_resource = service new_resource.component_name do
    supports :status => true, :restart => true
    action :nothing
  end
  new_resource.service_resource(service_resource)
end

action :create do
  include_recipe "logrotate"

  user_updated = create_user
  cfg_updated = create_config_file
  svc_updated = create_service

  create_logrotate_config

  if new_resource.updated_by_last_action(user_updated || cfg_updated || svc_updated)
    new_resource.notifies(:restart, new_resource.service_resource)
  end
end

action :enable do
  new_resource.service_resource.run_action(:enable)
  new_resource.updated_by_last_action(new_resource.service_resource.updated_by_last_action?)
end

action :restart do
  new_resource.service_resource.run_action(:restart)
  new_resource.updated_by_last_action(new_resource.service_resource.updated_by_last_action?)
end

action :start do
  new_resource.service_resource.run_action(:start)
  new_resource.updated_by_last_action(new_resource.service_resource.updated_by_last_action?)
end

protected

def create_user
  g = group new_resource.group do
    action :nothing
  end
  g.run_action(:create)

  user_group = new_resource.group
  user_home = new_resource.user_home
  u = user new_resource.user do
    gid user_group
    home user_home
    supports :manage_home => true
    action :nothing
  end
  u.run_action(:create)

  g.updated_by_last_action? || u.updated_by_last_action?
end

def create_config_file
  directory new_resource.config_dir do
    owner new_resource.user
    group new_resource.group
    recursive true
    action :nothing
  end.run_action(:create)

  t1 = template new_resource.config_file do
    source   "#{new_resource.name}-config.yml.erb"
    owner    new_resource.user
    group    new_resource.group
    mode     "0644"
    action :nothing
  end
  t1.run_action(:create)

  t1.updated_by_last_action?
end

def create_service
  t = template "/etc/init/#{new_resource.component_name}.conf" do
    cookbook new_resource.upstart_file_cookbook
    source   new_resource.upstart_file
    mode     0644
    variables(
      :component_name => new_resource.component_name,
      :path        => new_resource.ruby_path,
      :bin_file    => new_resource.bin_file,
      :binary      => new_resource.binary,
      :config_file => new_resource.config_file,
      :pid_file    => new_resource.pid_file,
      :user        => new_resource.user,
      :extra_args  => new_resource.extra_args
    )
    action :nothing
  end
  t.run_action(:create)

  l = link "/etc/init.d/#{new_resource.component_name}" do
    to "/lib/init/upstart-job"
    action :nothing
  end
  l.run_action(:create)

  t.updated_by_last_action? || l.updated_by_last_action?
end

def create_logrotate_config
  log_file = new_resource.log_file
  logrotate_app new_resource.component_name do
    cookbook "logrotate"
    path log_file
    frequency daily
    rotate 30
    create "644 root root"
  end
end
