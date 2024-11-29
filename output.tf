output "check1" {
  value = module.vpc1.private_subnets
}

output "check2" {
  value = module.vpc2.private_subnets
}

output "check3" {
  value = slice(module.vpc1.private_subnets, 0, 2)
}

output "check4" {
  value = slice(module.vpc2.private_subnets, 0, 2)
}
