#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

require_relative 'lib/vagrant_utils'

Vagrant.configure('2') do |config|
  # read in custom settings from the config.yml file
  provider_settings = load_config_file(File.join(get_config_dir, 'config.yml'))

  config.omnibus.chef_version = :latest
  config.berkshelf.enabled = true
 
  # Provider to install to
  # Valid providers: ['aws', 'rackspace', 'digital_ocean', 'cloudstack']
  ENV['VAGRANT_DEFAULT_PROVIDER'] = provider_settings.active_provider
  
  # Sets the ssh keys to be used to the default INSECURE keys. 
  # To create your own keys use ssh-keygen and change the path below.
  if provider_settings.active_provider != 'virtualbox'
    config.ssh.private_key_path = File.join(get_config_dir, 'ssh', provider_settings.ssh_key_name)
  end

  # Custom settings for the deployed virtual machine
  config.vm.define :static_cloud do |static_cloud|
    static_cloud.vm.hostname = "static-cloud"
  end 

  # Amazon
  config.vm.provider :aws do |aws, override|
    aws.access_key_id = provider_settings.aws.access_key_id
    aws.secret_access_key = provider_settings.aws.secret_access_key
    aws.keypair_name = provider_settings.aws.keypair_name

    aws.region = 'us-east-1'
    aws.ami = 'ami-5323523a'
    aws.instance_type = 'm1.large'
    aws.security_groups = %w[default]
    
    override.vm.box = 'aws'
    override.vm.box_url = get_current_vm_box_url(override.vm.box)
    override.ssh.username = 'ubuntu'
    override.ssh.private_key_path = config.ssh.private_key_path 
  end

  # Rackspace
  config.vm.provider :rackspace do |rackspace, override|
    rackspace.username = provider_settings.rackspace.username
    rackspace.api_key  = provider_settings.rackspace.api_key
    
    rackspace.public_key_path = "#{config.ssh.private_key_path}.pub"
    rackspace.flavor   = /8GB/
    rackspace.image    = /Ubuntu 10.04 LTS/

    override.vm.box = 'rackspace'
    override.vm.box_url = get_current_vm_box_url(override.vm.box)
    override.ssh.private_key_path = config.ssh.private_key_path
  end

  # Digital Ocean
  config.vm.provider :digital_ocean do |digitalocean, override|
    digitalocean.client_id = provider_settings.digital_ocean.client_id
    digitalocean.api_key = provider_settings.digital_ocean.api_key
    digitalocean.ssh_key_name = provider_settings.digital_ocean.ssh_key_name

    digitalocean.region = 'New York 1'
    digitalocean.image = 'Ubuntu 10.04 x64 Server'
    digitalocean.size = '8GB'

    override.vm.box = 'digital_ocean'
    override.vm.box_url = get_current_vm_box_url(override.vm.box)
  
    ENV['SSL_CERT_FILE'] = File.join(get_config_dir, 'certs', 'ca-bundle.crt')
  end

  # Cloudstack
  config.vm.provider :cloudstack do |cloudstack, override|
    cloudstack.host = "cloudstack.local"
    cloudstack.port = "8080"
    cloudstack.scheme = "http"
    cloudstack.api_key = ""
    cloudstack.secret_key = ""

    cloudstack.template_id = ""
    cloudstack.service_offering_id = ""
    cloudstack.network_id = ""
    cloudstack.zone_id = ""
    cloudstack.project_id = ""

    override.vm.box = 'cloudstack'
    override.vm.box_url = get_current_vm_box_url(override.vm.box)
  end

  # Virtualbox
  config.vm.provider :virtualbox do |virtualbox, override|
    virtualbox.customize ["modifyvm", :id, "--memory", "4096"]

    override.vm.network :forwarded_port, host: 80, guest: 80
    override.vm.network :forwarded_port, host: 443, guest: 443
    override.vm.network :forwarded_port, host: 8080, guest: 8080
    override.vm.box = "lucid64"
    override.vm.box_url = "http://files.vagrantup.com/lucid64.box"
  end

  # Enable provisioning with chef solo, specifying a cookbooks path, roles
  # path, and data_bags path (all relative to this Vagrantfile), and adding
  # some recipes and/or roles.
  #
  config.vm.provision :chef_solo do |chef|
    chef.cookbooks_path = File.expand_path(File.join(File.dirname(__FILE__), 'chef', 'cookbooks'))
    chef.roles_path = File.expand_path(File.join(File.dirname(__FILE__), 'chef', 'roles'))
    chef.data_bags_path = File.expand_path(File.join(File.dirname(__FILE__), 'chef', 'data_bags'))

    chef.add_role "cloudfoundry-user"

    chef.add_recipe "apt"
    chef.add_recipe "build-essential"
    chef.add_recipe "logrotate"
    chef.add_recipe "rbenv"
    chef.add_recipe "rsync"

    chef.json = { }
  end

  config.vm.provision :shell do |shell|
    shell.inline = "wget -q http://dl.static.com/install-static-cf.sh && sh ./install-static-cf.sh $1 && reboot"
    shell.args = provider_settings.hosting_domain
  end

end

# vim:set ft=ruby:

