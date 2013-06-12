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

# Where to write config files for all CloudFoundry components.
default['cloudfoundry']['config_dir']   = "/etc/cloudfoundry"

# Path to the directory used by components to store private data.
default['cloudfoundry']['data_dir']     = "/var/vcap/data"

# Where to write log files for all CloudFoundry components.
default['cloudfoundry']['log_dir']      = "/var/log/cloudfoundry"

# Where to write pid files for all CloudFoundry components.
default['cloudfoundry']['pid_dir']      = "/var/run/cloudfoundry"
