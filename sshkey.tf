resource "aws_key_pair" "deploy" {
  key_name   = "deploy-${var.env}"
  public_key = "${var.env == "stage" || var.env == "prod" ? var.ssh_keys["prod"] : var.ssh_keys["nonprod"]}"
}

variable "ssh_keys" {
  type = "map"

  default = {
    nonprod = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDj5kGWkJcJiRMU8V7robZXi7jIVutw/DQq00H+jzCsrVMOm1JzstYB8htx3olrpYCGgKVhrPSfMW2EvkrQ3krsupBX8Eoakvig1jwQ4RW+OqXRI5BKmFlOyrcBa7I57DExzCF99cYrIkii4NDBtVSA2WrYep7FqVzBiB/TcF0CUyebVS6d7qW2j10z+uciqemFSF8c32Wbd37QVT+0ddsiHwOEif9IAYrWpNuAPtuXV68ELz/M+cum8D9u7bKy6WEA1uiPQuMRVVkaWe0LN14kWB9haUFqtaphOKA1NJG2USCg7TZFskwHzPZGiNQG1dSLaziwMdSzUm9OJ0m9Or+b jenkins@eos.dev-spectrum.net"
    prod    = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDliJwVUoTVPfwDXI8NyzFPv9EGVdF6y5pq8W3vIi8s+5RfqCltLMYhu8pvultio+I63+2twB1znq664zYVi60igBQxDAFKMsJW72UvUPs6HzHRHlKZZrqC82FfLhwFxEb2jzjJCxyNwIHIRnsygkj2DOXAt3wEyWFvjs0nrrGuJdixmnPMO/MdT67m8QBO1yLnjutPDlSPkebdZn6k5I/z0/F9zxWt08g6CN5ygD0emL/Kr5QtooXjDAoT0s2eTrm89aXnGSYur1xVHavHUhsPji3WNVKZedxiNyzFIsB/wepy+mM5XiAzZxAkqgjVfxf4GPk0budU/nYmuuyrwzYr"
  }
}
