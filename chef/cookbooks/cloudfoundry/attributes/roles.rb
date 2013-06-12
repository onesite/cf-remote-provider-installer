#
# Cookbook Name:: cloudfoundry
# Attributes:: roles
#
# Copyright 2013, ZephirWorks
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

# The role that will be used to search for a cloud_controller node.
default['cloudfoundry']['roles']['cloud_controller'] = 'cloudfoundry_cloud_controller'

# The role that will be used to search for a cloud_controller node.
default['cloudfoundry']['roles']['cloud_controller_database_master'] = 'cloudfoundry_cloud_controller_database_master'

# The role that will be used to search for dea nodes.
default['cloudfoundry']['roles']['dea'] = 'cloudfoundry_dea'

# The role that will be used to search for a nats-server node.
default['cloudfoundry']['roles']['nats_server'] = 'cloudfoundry_nats_server'

# The role that will be used to search for a redis_vcap node.
default['cloudfoundry']['roles']['vcap_redis'] = 'cloudfoundry_redis_vcap'
