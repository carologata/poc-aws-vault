variable "region" {
  type    = string
  default = "sa-east-1"
}

variable "ingress_rules" {
  type    = list(number)
  default = [80, 443]
}

variable "egress_rules" {
  type    = list(number)
  default = [80, 443]
}