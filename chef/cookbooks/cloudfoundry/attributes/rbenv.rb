#
# Cookbook Name:: cloudfoundry
# Recipe:: rbenv
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

# The exact version of ruby-1.9.2 to install.
default['cloudfoundry']['ruby_1_9_2_version'] = "1.9.2-p290"

# The exact version of ruby to use to run components.
default['cloudfoundry']['ruby_version'] = "1.9.3-p286"

# The exact version of bundler to install.
default['cloudfoundry']['bundler_version'] = "1.1.3"
