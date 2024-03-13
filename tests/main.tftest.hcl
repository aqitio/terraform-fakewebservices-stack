
# WARNING: Generated module tests should be considered experimental and be reviewed by the module author.

variables {
  stack_prefix   = "test"
  server_count   = 2
  server_type    = "t2.micro"
  database_size  = 128
  vpc_cidr_block = "10.0.0.0/16"
  fake_token     = null
}

provider "fakewebservices" {
  // hostname = var.fws_hostname
  token    = var.fake_token
}

run "resource_validation" {
  assert {
    condition     = fakewebservices_vpc.vpc.name == "TEST_VPC"
    error_message = "incorrect VPC name"
  }

  assert {
    condition     = fakewebservices_vpc.vpc.cidr_block == "10.0.0.0/16"
    error_message = "incorrect VPC CIDR block"
  }

  assert {
    condition     = length(fakewebservices_server.server) == 2
    error_message = "incorrect server count"
  }

  assert {
    condition     = fakewebservices_server.server[0].name == "SRV_TEST_1"
    error_message = "incorrect server name"
  }

  assert {
    condition     = fakewebservices_server.server[0].type == "t2.micro"
    error_message = "incorrect server type"
  }

  assert {
    condition     = fakewebservices_server.server[0].vpc == "TEST_VPC"
    error_message = "incorrect server VPC"
  }

  assert {
    condition     = fakewebservices_load_balancer.load_balancer.name == "TEST_LB"
    error_message = "incorrect load balancer name"
  }

  assert {
    condition     = contains(fakewebservices_load_balancer.load_balancer.servers, "SRV_TEST_1")
    error_message = "load balancer does not contain server"
  }

  assert {
    condition     = fakewebservices_database.database.name == "TEST_DB"
    error_message = "incorrect database name"
  }

  assert {
    condition     = fakewebservices_database.database.size == 128
    error_message = "incorrect database size"
  }
}