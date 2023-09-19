Vagrant.configure("2") do |config|
 config.vm.define "staging" do |staging|
  staging.vm.box = "hashicorp/bionic64"
  staging.vm.hostname = "demo-ops"
  staging.vm.network :private_network, ip: "172.28.128.10"

  staging.vm.provider :virtualbox do |v|
    v.name = "demo-ops"
    v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
    v.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
  end

  staging.vm.provision :ansible do |deploy|
    deploy.playbook = "playbook.yml"
  end
 end
end

