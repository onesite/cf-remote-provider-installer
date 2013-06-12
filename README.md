# Static Cloud Manager Remote Provider Install
This guide will help you setup and deploy a Cloud Foundry Core instance to be controlled by the [Static Cloud Manager](https://manage.static.com) at a remote providers datacenter.

##Setup
1. A Ruby setup is required to run the installer. If not already installed on the system instructions can be found in the [Installing Ruby](#Installing Ruby)  section below for your given environment.

1. Setup your desired provider, links are provided below in the [Provider Setup Information](#provider).

1. Download and install [Vagrant](http://www.vagrantup.com) from [here](http://downloads.vagrantup.com/tags/v1.2.2).

1. From the command line install the following required plugins by typing the followind commands:
		
		vagrant plugin install vendor/cache/vagrant-omnibus-*.gem
		vagrant plugin install vendor/cache/vagrant-berkshelf-*.gem
		vagrant plugin install vendor/cache/vagrant-aws-*.gem
		vagrant plugin install vendor/cache/vagrant-rackspace-*.gem
		vagrant plugin install vendor/cache/vagrant-digitalocean-*.gem
		
	or you can run
	
		for i in omnibus berkshelf aws rackspace digitalocean; do vagrant plugin install vendor/cache/vagrant-$i-*.gem; done
		
1. You will need ssh keys in order to connect to the deployed machine instance. Insecure ssh keys are preconfigured and provided for you to use or if you like you can create custom ssh keys for use. Instructions for both options are provided as follows:

	1. To use the provided insecure ssh keys copy 
	
			mv config/ssh/static_id_rsa.default config/ssh/static_id_rsa
			mv config/ssh/static_id_rsa.default.pub config/ssh/static_id_rsa.pub

	2. To create custom ssh keys and store them in the `config/ssh` folder with the following command: 

			ssh-keygen -t rsa -C static_id_rsa -f config/ssh/static_id_rsa

1. To configure the deployment for the desired provider and its options you first must copy `config/config.yml.default` to `config/config.yml` and edit this configuration file based on the the following options:

	* Change the `active_provider` variable to your desired provider you wish to deploy to, choices are:
		* aws
		* rackspace
		* digital_ocean
	* Set the `hosting_domain` variable to your custom domain where applications will be deployed and hosted from. The installer, when finished, will prompt you with results for you to use to set a DNS wildcard for `*.{YOUR CUSTOM DOMAIN HERE}`.
	* If you modified the ssh key in the previous step set `ssh_key_name` to the location of your new key
	* Configure the given section for the specific provider. Links are provided below in the [Provider Setup Information](#provider) section for the information needed.
		* NOTE: the `ssh_key_name` or `keypair_name` will be the name that you have set the ssh key name for within the providers control panel. The generated `config/ssh/static_id_rsa.pub` file will contain the string to paste on the providers control panel ssh keys settings page. 
		
1. Deploy Cloud Foundry to the configured provider with the following command: 

		vagrant up

	this may take awhile depending on the given provider. When finished the installer will print out the necessary information and create a `cloud.settings` file. These settings are used within the Static Cloud Manager remote provider setting page located at `http://{YOUR-CONFIGURED-STATIC-CLOUD-MANAGER-DOMAIN}/admin/datacenter/sites/plugins` in order to control and deploy PaaS applications.
	

## Provider Setup information
The following links will provide you with the locations for finding the necessary information to fill in the `config/config.yml` configuration file. 

### Amazon AWS

* Login to [Amazon AWS control panel](https://console.aws.amazon.com) and setup your Amazon account. Region of us-east-1 is assumed for all links.

	- [Amazon API Access Key and Secret](https://console.aws.amazon.com/iam/home?#security_credential)
	- [Amazon SSH Keys](https://console.aws.amazon.com/ec2/home?region=us-east-1#s=KeyPairs)
		* name: static_id_rsa
		* provided key: 
					
				ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCvYx/Sa0ucg73SJxkFMsutg1+iiNpUc2hXXiu/dMZijhiNQ/acMQjka1fx01cMSJ2+ZDU//6QPlxN8nLecrD7eWMfYARM7yOWaj/Zc6qipORMH0re38wCP2AlwOW70rNjf0j9QAf5M6h6allFRR8FHi3XjrKpvKevzBQIcy0sSM3tLzsrq2rkdsMFP/FJ0dcIof+Ktj/wMgN3Uaxj8I9F9yqScSiyTe0OG1YrAhbYEUzvgSJdBUyYwp6XIAVvo1lkt1zFz+mSUaKEFIFXVlScFLPx6fnViE+1LARAqKqd7Vi6ZyVurmoLbcoThIzlClc4N+B7yfaECRZCUSSN/f9yJ static_id_rsa
					
	- [Security Groups](https://console.aws.amazon.com/ec2/home?region=us-east-1#s=SecurityGroups)
		* Enable ports 22, 80, 443, 8080 for the default security group 
		
### Rackspace

* Login to the [Rackspace control panel](https://manage.rackspacecloud.com) and setup your Rackspace account

	- [Rackspace Username and API key](https://manage.rackspacecloud.com/APIAccess.do)

### Digital Ocean

* Login to the [Digital Ocean control panel](www.digitalocean.com/login) and setup your Digital Ocean account

	- [Digital Ocean Access Key and Secret](https://www.digitalocean.com/api_access)
	- [Digital Ocean SSH Keys](https://www.digitalocean.com/ssh_keys)
		* name: static_id_rsa
		* provided key: 
					
				ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCvYx/Sa0ucg73SJxkFMsutg1+iiNpUc2hXXiu/dMZijhiNQ/acMQjka1fx01cMSJ2+ZDU//6QPlxN8nLecrD7eWMfYARM7yOWaj/Zc6qipORMH0re38wCP2AlwOW70rNjf0j9QAf5M6h6allFRR8FHi3XjrKpvKevzBQIcy0sSM3tLzsrq2rkdsMFP/FJ0dcIof+Ktj/wMgN3Uaxj8I9F9yqScSiyTe0OG1YrAhbYEUzvgSJdBUyYwp6XIAVvo1lkt1zFz+mSUaKEFIFXVlScFLPx6fnViE+1LARAqKqd7Vi6ZyVurmoLbcoThIzlClc4N+B7yfaECRZCUSSN/f9yJ static_id_rsa

### Providers Coming Soon
* Cloudstack
* OpenStack
* VSphere
* Eucalyptus
* Windows Azure


## Installing Ruby 
The following guide will walk you through how to install and setup Ruby for your current system

### OS X

1. Ruby setup 
	1. Using the system Ruby install 
    	* If you choose to run with the system version of ruby all `install` commands will have to be prepended with sudo to avoid ** You don't have write permissions into ... ** errors.

		* To install the gems locally rather than at the system level you can use the following configuration in your terminal. Edit your default environment settings, typically located in your ~/.bash_profile, and add the following

				# Ruby Configuration
				export GEM_HOME=$HOME/.gem
				export PATH=$PATH:$GEM_HOME/bin
                
	1. Or you can use an [RVM](https://rvm.io) Install
       	* [RVM](https://rvm.io) will automatically set the `GEM_HOME` environment variable for you when selecting the desired ruby version
		* [RVM](https://rvm.io) can be installed manually via the command line by running 

				$ curl -#L https://get.rvm.io | bash -s stable --ruby

		* On OS X RVM also offers a GUI to simplify management of Ruby version and gems called [JewelryBox](http://jewelrybox.unfiniti.com)


### Ubuntu
1. Dependency Install

		apt-get install curl build-essential openssl libreadline6 libreadline6-dev curl git-core zlib1g zlib1g-dev libssl-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt-dev autoconf libc6-dev libgdbm-dev ncurses-dev automake libtool bison subversion pkg-config libffi-dev

1. Ruby setup 		
	1. Using apt-get you can install ruby 
		
			apt-get install ruby rubygems
	
	1. Using an [RVM](https://rvm.io) Install
       	* [RVM](https://rvm.io) will automatically set the `GEM_HOME` environment variable for you when selecting the desired ruby version
		* [RVM](https://rvm.io) can be installed manually via the command line by running 

				$ curl -#L https://get.rvm.io | bash -s stable --ruby


### Windows
1. Ruby setup
	* Download and install [Ruby Installer for Windows](http://rubyinstaller.org/downloads/). When using the command line be sure to use the Ruby-enabled command prompt window. You access this command prompt from the Windows Start menu (All Programs > Ruby <version> > Start Command Prompt with Ruby).
	
	
	
## License
---
Except as otherwise noted this software is licensed under the [Apache License, Version 2.0](http://www.apache.org/licenses/LICENSE-2.0.html)

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

  http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

