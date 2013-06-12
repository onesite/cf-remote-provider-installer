Description
===========

Helper cookbook that groups common functionality for all other
CloudFoundry cookbooks.

Requirements
============

Platform
--------

* Ubuntu

Tested on:

* Ubuntu 10.04
* Ubuntu 12.04

Cookbooks
---------

* apt
* logrotate
* rbenv

Usage
=====

You should never need to use any recipes in this cookbook on their own.
Instead, you should include recipes from the higher level CloudFoundry
cookbooks such as `cloudfoundry-dea` and
`cloudfoundry-cloud_controller`.

Attributes
==========

User and group
--------------

* `node['cloudfoundry']['user']` - User that will own and run CloudFoundry. Default is `cloudfoundry`.
* `node['cloudfoundry']['group']` - Group of the user that will own and run CloudFoundry. Default is `cloudfoundry`.
* `node['cloudfoundry']['uid']` - Uid of the user that will own and run CloudFoundry. Default is `1002`.
* `node['cloudfoundry']['gid']` - Gid of the user that will own and run CloudFoundry. Default is `1002`.
* `node['cloudfoundry']['home']` - Home of the user that will own and run CloudFoundry. Default is `"/home/#{node['cloudfoundry']['user']}"`.

Directories
-----------

* `node['cloudfoundry']['config_dir']` - Where to write config files for all CloudFoundry components. Default is `/etc/cloudfoundry`.
* `node['cloudfoundry']['data_dir']` - Path to the directory used by components to store private data. Default is `/var/vcap/data`.
* `node['cloudfoundry']['log_dir']` - Where to write log files for all CloudFoundry components. Default is `/var/log/cloudfoundry`.
* `node['cloudfoundry']['pid_dir']` - Where to write pid files for all CloudFoundry components. Default is `/var/run/cloudfoundry`.

Rbenv
-----

* `node['cloudfoundry']['ruby_version']` - The exact version of ruby to use to
  run components. Defaults to `1.9.3-p286`.

Nats
----

All components in a CloudFoundry cluster need access to a Nats server.

The recommended way to configure the server is to use search:

* `node['cloudfoundry']['roles']['nats_server']` - The role that will be used
  to search for a Nats server node. Default is `cloudfoundry_nats_server`.

If for some reason you can't or won't use search, you need to specify connection information on each node
(ideally, using a role):

* `node['cloudfoundry']['nats_server']['host']` - Host of the Nats Server that all CloudFoundry components will use for messaging. Default is `localhost"`.
* `node['cloudfoundry']['nats_server']['port']` - Port of the Nats Server that all CloudFoundry components will use for messaging. Default is `4222"`.
* `node['cloudfoundry']['nats_server']['user']` - Host of the Nats Server that all CloudFoundry components will use for messaging. Default is `nats"`.
* `node['cloudfoundry']['nats_server']['password']` - Port of the Nats Server that all CloudFoundry components will use for messaging. Default is `nats"`.

Miscellaneous
-------------

* `node['cloudfoundry']['domain']` - Main external domain. Defaults to
  `vcap.me`.
* `node['cloudfoundry']['local_route']` - local_route is the IP address of a well known server on your network, it is used to choose the right ip address (think of hosts that have multiple nics and IP addresses assigned to them) of the host running the cloud controller. Default value of nil, should work in most cases. Default is `nil`.
* `node['cloudfoundry']['capacity']['memory']` - Maximum amount of memory that an application can request. Default is `2048`.
* `node['cloudfoundry']['capacity']['max_uris']` - Maximum number of uris to which an application can be bound. Default is `4`.
* `node['cloudfoundry']['capacity']['max_services']` - Maximum number of services to which an application can be bound. Default is `16`.
* `node['cloudfoundry']['capacity']['max_apps']` - Maximum number of applications that a user can have. Default is `20`.
* `node['cloudfoundry']['service_token']` - The token to use to authenticate services to cloudfoundry. Default is `0xdeadbeef`.

Roles
-----

* `node['cloudfoundry']['roles']['cloud_controller']` - The role that will be
  used to search for a cloud_controller node. Defaults to
  `cloudfoundry_cloud_controller`.
* `node['cloudfoundry']['roles']['cloud_controller_database_master']` - The
  role that will be used to search for a node running the PostgreSQL DB that the
  `cloud_controller` will use. If the role is `nil`, or if no node is found with
  this role, the `cloud_controller` will assume a local DB. Defaults to
  `cloudfoundry_cloud_controller_database_master`.
* `node['cloudfoundry']['roles']['dea']` - The role that will be used to
  search for dea nodes.. Defaults to `cloudfoundry_dea`.
* `node['cloudfoundry']['roles']['nats_server']` - The role that will be used
  to search for a Nats server node. Defaults to `cloudfoundry_nats_server`.
* `node['cloudfoundry']['roles']['vcap_redis']` - The role that will be used
  to search for a redis_vcap node. Default is `cloudfoundry_redis_vcap`.

License and Author
==================

Author:: Andrea Campi (<andrea.campi@zephirworks.com>)
Author:: Trotter Cashion (<cashion@gmail.com>)

Copyright:: 2012-2013 ZephirWorks
Copyright:: 2012 Trotter Cashion

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
