resource "aws_key_pair" "deploy" {
  count = "${var.env == "dev" || var.env == "uat" ? 1 : 0}"
  key_name   = "${var.deploy_key_name}"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDj5kGWkJcJiRMU8V7robZXi7jIVutw/DQq00H+jzCsrVMOm1JzstYB8htx3olrpYCGgKVhrPSfMW2EvkrQ3krsupBX8Eoakvig1jwQ4RW+OqXRI5BKmFlOyrcBa7I57DExzCF99cYrIkii4NDBtVSA2WrYep7FqVzBiB/TcF0CUyebVS6d7qW2j10z+uciqemFSF8c32Wbd37QVT+0ddsiHwOEif9IAYrWpNuAPtuXV68ELz/M+cum8D9u7bKy6WEA1uiPQuMRVVkaWe0LN14kWB9haUFqtaphOKA1NJG2USCg7TZFskwHzPZGiNQG1dSLaziwMdSzUm9OJ0m9Or+b jenkins@eos.dev-spectrum.net"
}
