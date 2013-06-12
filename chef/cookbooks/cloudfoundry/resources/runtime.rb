#
# Cookbook Name:: cloudfoundry
# Resource:: runtime
#
# Copyright 2012-2013, ZephirWorks
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

actions :create
default_action :create

attribute :name, :kind_of => String, :name_attribute => true
attribute :version, :kind_of => String, :required => true
attribute :description, :kind_of => String, :required => true
attribute :executable, :kind_of => String, :required => true
attribute :version_flag, :kind_of => String, :required => true
attribute :version_output, :kind_of => String, :required => true
attribute :additional_checks, :kind_of => [String, NilClass], :default => nil
attribute :default, :kind_of => [TrueClass, FalseClass], :default => false
attribute :frameworks, :kind_of => Array, :default => []
