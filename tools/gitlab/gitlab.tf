data "template_file" "gitlab_user_data" {
	template = "${file("${path.module}/gitlab_userdata.tpl")}"
}	

resource "aws_instance" gitlab {
	ami                    = "${var.gitlab_ami}"
	instance_type          = "${var.gitlab_instance_type}"
	key_name               = "${var.gitlab_key_name}"
	vpc_security_group_ids = ["${var.gitlab_security_group}"]
	subnet_id              = "${var.gitlab_subnet}"	
	user_data              = "${data.template_file.gitlab_user_data.rendered}"	

	tags {
		Name = "Gitlab"
	}
}
