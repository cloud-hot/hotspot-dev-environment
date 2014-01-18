VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "hotspot-precise64"
  config.vm.box_url = "http://files.vagrantup.com/precise64.box"
  config.vm.hostname = 'hotspot-dev-box'

  config.vm.network :forwarded_port, guest: 6000, host: 6000
  config.vm.network :private_network, ip: "192.168.2.2"

  # used by company to setup gitlab.
  # config.vm.network :public_network

  config.vm.synced_folder "../vagrant-share", "/vagrant_data", type: "nfs"
  
  config.vm.provider :virtualbox do |v|
    v.gui = false

    v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
    v.customize ["modifyvm", :id, "--memory", 1024]
  end

  config.vm.provision :puppet do |puppet|
    puppet.manifests_path = 'puppet/manifests'
    puppet.module_path    = 'puppet/modules'
    puppet.manifest_file  = "hotspot-precise64.pp"
    puppet.options = ['--debug']
  end

end
