# This data source will produce the most recent AMI with the name pattern as
# provided in var.image and owner as specified.
#
# To use AMIs by this owner, an EULA has to be accepted once using the AWS
# Console.
data "aws_ami" "ami" {
  most_recent = true

  filter {
    name   = "image-id"
    values = [var.image]
  }
}

# The default tags are needed to prevent Puppet AWS reaper from reaping the instances
locals {
  tags = merge({
    description = "Node provisioned via Puppet Provisioner Module"
  }, var.tags)
}

# In both large and standard we only require a single Primary but under a
# standard architecture the instance will also serve catalogs as a Compiler in
# addition to hosting all other core services. 
resource "aws_instance" "server" {
  ami                    = data.aws_ami.ami.id
  instance_type          = var.instance_type
  count                  = var.node_count
  key_name               = var.ssh_key
  subnet_id              = var.subnet_id
  vpc_security_group_ids = var.security_group_ids
  tags                   = merge(local.tags, tomap({
    "Name" = "${var.name}-${count.index + 1}"
  }))

  root_block_device {
    volume_size = var.root_block_device.volume_size
    volume_type = var.root_block_device.volume_type
  }
}
