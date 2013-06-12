#
# Cookbook Name:: cloudfoundry
# Recipe:: default
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

# Main external domain.
default['cloudfoundry']['domain'] = 'vcap.me'

# local_route is the IP address of a well known server on your network, it
# is used to choose the right ip address (think of hosts that have multiple nics
# and IP addresses assigned to them) of the host running the cloud controller. Default
# value of nil, should work in most cases.
default['cloudfoundry']['local_route'] = nil

# Maximum amount of memory that an application can request.
default['cloudfoundry']['capacity']['memory'] = 2048

# Maximum number of uris to which an application can be bound.
default['cloudfoundry']['capacity']['max_uris'] = 4

# Maximum number of services to which an application can be bound.
default['cloudfoundry']['capacity']['max_services'] = 16

# Maximum number of applications that a user can have.
default['cloudfoundry']['capacity']['max_apps'] = 20

# The token to use to authenticate services to cloudfoundry. This _may_
# not be safe to change.
default['cloudfoundry']['service_token'] = "0xdeadbeef"
