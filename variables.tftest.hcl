
# WARNING: Generated module tests should be considered experimental and be reviewed by the module author.

run "variables_validation" {
  variables {
    stack_prefix   = "test"
    server_count   = 1
    server_type    = "t2.micro"
    database_size  = 128
    vpc_cidr_block = "10.0.0.0/16"
  }

  assert {
    condition     = var.stack_prefix == "test"
    error_message = "incorrect value for stack_prefix"
  }

  assert {
    condition     = var.server_count == 1
    error_message = "incorrect value for server_count"
  }

  assert {
    condition     = var.server_type == "t2.micro"
    error_message = "incorrect value for server_type"
  }

  assert {
    condition     = var.database_size == 128
    error_message = "incorrect value for database_size"
  }

  assert {
    condition     = var.vpc_cidr_block == "10.0.0.0/16"
    error_message = "incorrect value for vpc_cidr_block"
  }
}