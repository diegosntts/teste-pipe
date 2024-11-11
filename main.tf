provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "web_app" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "m5.large"
  key_name      = "my-key"

  root_block_device {
    volume_size = 100
    volume_type = "gp3"
  }

  tags = {
    Name = "HighCostExampleInstance"
  }
}

resource "aws_ebs_volume" "extra_storage" {
  availability_zone = "us-east-1a"
  size              = 500
  type              = "gp2"
  tags = {
    Name = "ExtraStorage"
  }
}

resource "aws_volume_attachment" "ebs_att" {
  device_name  = "/dev/sdf"
  volume_id    = aws_ebs_volume.extra_storage.id
  instance_id  = aws_instance.web_app.id
  force_detach = true
}
