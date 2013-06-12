#
# Cookbook Name:: cloudfoundry
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

class Chef
  module Mixin
    module CloudfoundryNodes
      include Chef::Mixin::Language # for search

      def cloud_controller_domain
        node['cloudfoundry']['domain']
      end

      def cloud_controller_url
        if node['cloudfoundry']['api_url']
          node['cloudfoundry']['api_url']
        else
          "http://api.#{node['cloudfoundry']['domain']}"
        end
      end

      def cf_nats_server_node
        if Chef::Config[:solo]
          Chef::Log.warn "cf_nats_server_node is not meant for Chef Solo"
          return nil
        end

        cf_role = node['cloudfoundry']['roles']['nats_server']

        if node.run_list.roles.include?(cf_role)
          return node
        end

        results = search(:node, "role:#{cf_role} AND chef_environment:#{node.chef_environment}")
        if results.size >= 1
          results[0]
        else
          Chef::Log.warn "cf_nats_server_node found no nats_server"
          nil
        end
      end

      #
      # Look for the Nats Server to use.
      #
      # We will try a search first; if we find a suitable node, we will get the
      # attributes from there.
      # If that fails we will then look for attributes set on the current node.
      #
      def cf_mbus_url
        if !Chef::Config[:solo] && cf_node = cf_nats_server_node
          nats_attrs = cf_node['nats_server']
          host = cf_node.attribute?('cloud') ? cf_node['cloud']['local_ipv4'] : cf_node['ipaddress']
          return "nats://#{nats_attrs['user']}:#{nats_attrs['password']}@#{host}:#{nats_attrs['port']}/"
        end

        nats_attrs = node['cloudfoundry']['nats_server']
        "nats://#{nats_attrs['user']}:#{nats_attrs['password']}@#{nats_attrs['host']}:#{nats_attrs['port']}/"
      end

      def cf_vcap_redis_node
        if Chef::Config[:solo]
          Chef::Log.warn "cf_vcap_redis_node is not meant for Chef Solo"
          return nil
        end

        cf_role = node['cloudfoundry']['roles']['vcap_redis']

        if node.run_list.roles.include?(cf_role)
          return node
        end

        results = search(:node, "role:#{cf_role} AND chef_environment:#{node.chef_environment}")
        if results.size >= 1
          results[0]
        else
          Chef::Log.warn "cf_vcap_redis_node found no vcap_redis"
          nil
        end
      end

      def cf_runtimes_include?(name)
        cf_runtimes.include?(name)
      end

      def cf_runtimes_get(name)
        cf_runtimes[name]
      end

      def cf_runtimes
        runtimes = cf_dea_runtimes
        runtimes.merge!(node['cloudfoundry']['runtimes'].to_hash)

        Chef::Log.debug "cf_runtimes returning #{runtimes.inspect}"
        runtimes
      end

      def cf_dea_runtimes
        if Chef::Config[:solo]
          return {}
        end

        dea_role = node['cloudfoundry']['roles']['dea']
        results = search(:node, "roles:#{dea_role} AND chef_environment:#{node.chef_environment}")
        unless results.any?
          Chef::Log.warn "No DEA found with a search for roles:#{dea_role}"
          return {}
        end

        runtimes = results.inject({}) do |acc,n|
          dea_runtimes = n['cloudfoundry']['runtimes'] || {}
          Chef::Log.debug "DEA #{n} has #{dea_runtimes.count} runtimes"
          acc.merge(dea_runtimes)
        end

        Chef::Log.debug "cf_dea_runtimes returning #{runtimes.inspect}"
        runtimes
      end
    end
  end
end

Chef::Recipe.send(:include, Chef::Mixin::CloudfoundryNodes)
::Erubis::Context.send(:include, Chef::Mixin::CloudfoundryNodes)
