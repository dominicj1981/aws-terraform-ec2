provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region = "us-east-1"
}

variable "hostnames" {
  type = "map"
  default = {
    "0" = "app-1.yourdomain.com"
    "0" = "app-2.yourdomain.com"
  }
}

variable "aws_amis" {
  type = "map"
  default = {
    us-east-1 = "ami-f0e7d19a"
  }
}

resource "template_file" "web_init" {
  count    = "${var.count}"
  template = "${file("web_init.tpl")}"
  vars {
    hostname = "${lookup(var.hostnames, count.index)}"
  }
}

resource "aws_instance" "ci" {
  ami = "${var.aws_amis}"
  instance_type = "${var.instance_type}"
  key_name = "${var.key_name}"
  subnet_id = "${var.subnet_id}"
  security_groups = [ "${var.security_groups}" ]
  count = "${var.count}"
  user_data = "${element(template_file.web_init.*.rendered, count.index)}"

  tags {
      Name = "${format("${var.instance_name}%03d", count.index + 1)}"
  }   
}

resource "aws_eip" "ip" {
  instance = "${aws_instance.ci.id}"
  depends_on = ["aws_instance.ci"]
  vpc = true
}

resource "aws_route53_record" "www" {
  zone_id = "${var.aws_route53_zone_id}"
  name = "${lookup(var.hostnames, count.index)}"
  type = "A"
  ttl = "5"
  records = ["${aws_eip.ip.public_ip}"]
}



