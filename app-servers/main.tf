provider "aws" {
  region = var.aws_region
}

variable "hostnames" {
  type = "map"
  default = {
    "0" = "app-1.foo.bar"
    "1" = "app-2.foo.bar"
  }
}

variable "aws_amis" {
  type = "map"
    default = {
        eu-west-1= "ami-f0e7d19a"
    }
}

resource "template_file" "web_init" {
  count    = "${var.count}"
  template = "${file("web_init.tpl")}"
  vars {
    hostname = "${lookup(var.hostnames, count.index)}"
  }
}

resource "aws_instance" "app" {
    ami = "${var.aws_amis}"
    instance_type = "${var.instance_type}"
    key_name= "${var.key_name}"
    subnet_id= "${var.subnet_id}"
    count = "${var.count}"
    user_data = "${element(template_file.web_init.*.rendered, count.index)}"

	tags {
      Name = "${format("${var.instance_name}%03d", count.index + 1)}"
    }    
}


