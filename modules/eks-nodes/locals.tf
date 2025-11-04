locals {
  asg_ami = var.asg_ami != null ? var.asg_ami : data.aws_ami.eks.id
  zones   = ["a", "b", "c", "d", "e", "f", "g", "h"]
  # New zones field accepts ints and null, logic in place to handle either case.
  asg_zones = length(var.az_list) > 0 ? [
    for zone in var.az_list : contains(local.zones, zone) ? index(local.zones, zone) : null
  ] : null
  minion_tags = [
    for k, v in var.minion_tags : {
      key   = k
      value = v
    }
  ]
  metadata = [
    for k, v in var.metadata : {
      key   = k
      value = v
    }
  ]
}
