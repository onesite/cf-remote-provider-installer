#
# Cookbook Name:: cloudfoundry
# Recipe:: user
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

node.default['cloudfoundry']['home'] = "/home/#{node['cloudfoundry']['user']}"

group node['cloudfoundry']['group'] do
  gid node['cloudfoundry']['gid']
end

user node['cloudfoundry']['user'] do
  uid       node['cloudfoundry']['uid']
  gid       node['cloudfoundry']['gid']
  home      node['cloudfoundry']['home']
  supports  :manage_home => true
end
