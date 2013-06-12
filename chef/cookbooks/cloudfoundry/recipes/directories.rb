#
# Cookbook Name:: cloudfoundry
# Recipe:: directories
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

%w[config_dir data_dir log_dir pid_dir].each do |d|
  directory node['cloudfoundry'][d] do
    recursive true
    owner node['cloudfoundry']['user']
    mode  0755
  end
end
