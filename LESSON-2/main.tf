
resource "yandex_compute_instance" "elastic_single_node" {
  name        = "elk"
  platform_id = "standard-v1"
  zone        = "ru-central1-a"

  resources {
    cores  = 2
    memory = 4
  }

  boot_disk {

    initialize_params {
      size = "30"  
      image_id = "fd8vmcue7aajpmeo39kk"
    
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.service.id
    nat=true
  }

  metadata = {
    foo      = "bar"
    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
  }
  
  connection {
    type = "ssh"
    user = "ubuntu"
    private_key = file("~/.ssh/id_rsa")
    host = "${self.network_interface[0].nat_ip_address}"
    port = "22"
    timeout     = "320s"
  }

   provisioner "remote-exec" {
    inline = [
      "ip a",
      "sudo sysctl -w vm.max_map_count=262144",
  "sudo mkdir /opt",
  "sudo mkdir /opt/elastic/",
  "sudo mkdir /opt/elastic/esdata/",
  "sudo chmod 777 -R /opt/elastic/esdata",
  "sudo apt-get remove docker docker-engine docker.io containerd runc",
  "sudo apt-get update",
  "sudo apt-get install -y apt-transport-https ca-certificates curl gnupg-agent software-properties-common",
  "curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -",
  "sudo apt-key fingerprint 0EBFCD88",
  "sudo add-apt-repository \"deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable\"",
  "sudo apt-get update && sudo apt-get install -y docker-ce docker-ce-cli containerd.io",
  "sudo curl -L \"https://github.com/docker/compose/releases/download/1.28.4/docker-compose-$(uname -s)-$(uname -m)\" -o /usr/local/bin/docker-compose",
  "sudo chmod +x /usr/local/bin/docker-compose",
  "sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose"
         
    ]
  }

    provisioner "local-exec" {   
     command = "${file("deploy/install.sh")}"
     on_failure= "fail"
        environment = {
      WORKDIR = "/tmp/elk"
      NODE_GROUP = "elk"
      HOST_NAME = "${self.name}"

      ANSIBLE_HOST = "${self.network_interface[0].nat_ip_address}"
      ANSIBLE_CONNECTION = "ssh"
      ANSIBLE_USER = "ubuntu"
      STATE="stage"
      PROJECT_NAME="elk_single_node"
    }
  }


}

resource "yandex_vpc_network" "service" {
     name = "service"
}

resource "yandex_vpc_subnet" "service" {
  v4_cidr_blocks = ["10.168.1.0/25"]
  zone       = "ru-central1-a"
  network_id = "${yandex_vpc_network.service.id}"
}