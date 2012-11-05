# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant::Config.run do |config|
	config.vm.box     = 'precise64'
	config.vm.box_url = 'http://files.vagrantup.com/precise64.box'

	props = { 'memory' => 6144, 'ip1' => '172.16.0.3' }
	name = 'openstack'

	config.vm.forward_port(22, 2222)

	config.vm.network :hostonly, props['ip1'], :adapter => 2
	config.vm.network :hostonly, props['ip1'].gsub(/(\d+\.\d+)\.\d+\.(\d+)/) {|x| "#{$1}.1.#{$2}" }, :adapter => 3
	config.vm.network :hostonly, props['ip1'].gsub(/(\d+\.\d+)\.\d+\.(\d+)/) {|x| "#{$1}.2.#{$2}" }, :adapter => 4

	config.vm.customize ["modifyvm", :id, "--memory", props['memory'] || 2048 ]
	config.vm.customize ["modifyvm", :id, "--name", "#{name}.puppetlabs.lan"]
	config.vm.host_name = "#{name.gsub('_', '-')}.puppetlabs.lan"

	node_name = "#{name.gsub('_', '-')}-#{Time.now.strftime('%Y%m%d%m%s')}"

	config.vm.provision :shell, :inline => "apt-get update"

	config.vm.provision :puppet do |puppet|
		puppet.manifests_path = 'manifests'
		puppet.manifest_file  = 'hosts.pp'
		puppet.module_path    = 'modules'
		puppet.options = ['--verbose', "--certname=#{node_name}"]
	end

	config.vm.provision :puppet do |puppet|
		puppet.manifests_path = 'manifests'
		puppet.manifest_file  = 'site.pp'
		puppet.module_path    = 'modules'
		puppet.options = ['--verbose', "--certname=#{node_name}"]
	end
end
