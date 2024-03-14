# Define variables
variables {
  # Define the stack prefix variable
  stack_prefix = "test"
  # Define the server count variable
  server_count = 2
  # Define the server type variable
  server_type = "t2.micro"
  # Define the database size variable
  database_size = 128
  # Define the VPC CIDR block variable
  vpc_cidr_block = "10.0.0.0/16"
  # Define the hostname for the Fake Web Services provider
  fws_hostname = "app.terraform.io"
}

# Configure the Fake Web Services provider
provider "fakewebservices" {
  # Set the hostname for the provider to the value of the fws_hostname variable
  hostname = var.fws_hostname
  # Set the token for the provider to the value of the fake_token variable
  token = var.fake_token
}

# Define a Terraform Cloud run for testing "fakewebservices_vpc" resources
run "fakewebservices_vpc" {
  # Assert conditions for resource validation
  assert {
    # Check if the VPC name is "TEST_VPC"
    condition = fakewebservices_vpc.vpc.name == "TEST_VPC"
    # Error message to display if condition is not met
    error_message = "incorrect VPC name"
  }

  assert {
    # Check if the VPC CIDR block is "10.0.0.0/16"
    condition = fakewebservices_vpc.vpc.cidr_block == "10.0.0.0/16"
    # Error message to display if condition is not met
    error_message = "incorrect VPC CIDR block"
  }
}

# Define a Terraform Cloud run for testing "fakewebservices_server" resources
run "fakewebservices_server" {

  assert {
    # Check if the length of the server list is 2
    condition = length(fakewebservices_server.server) == 2
    # Error message to display if condition is not met
    error_message = "incorrect server count"
  }

  assert {
    # Check if the name of the first server is "SRV_TEST_1"
    condition = fakewebservices_server.server[0].name == "SRV_TEST_1"
    # Error message to display if condition is not met
    error_message = "incorrect server name"
  }

  assert {
    # Check if the type of the first server is "t2.micro"
    condition = fakewebservices_server.server[0].type == "t2.micro"
    # Error message to display if condition is not met
    error_message = "incorrect server type"
  }

  assert {
    # Check if the VPC of the first server is "TEST_VPC"
    condition = fakewebservices_server.server[0].vpc == "TEST_VPC"
    # Error message to display if condition is not met
    error_message = "incorrect server VPC"
  }
}

# Define a Terraform Cloud run for testing "fakewebservices_load_balancer" resources
run "fakewebservices_load_balancer" {

  assert {
    # Check if the name of the load balancer is "TEST_LB"
    condition = fakewebservices_load_balancer.load_balancer.name == "TEST_LB"
    # Error message to display if condition is not met
    error_message = "incorrect load balancer name"
  }

  assert {
    # Check if the load balancer contains the server "SRV_TEST_1"
    condition = contains(fakewebservices_load_balancer.load_balancer.servers, "SRV_TEST_1")
    # Error message to display if condition is not met
    error_message = "load balancer does not contain server"
  }
}

# Define a Terraform Cloud run for testing "fakewebservices_database" resources
run "fakewebservices_database" {

  assert {
    # Check if the name of the database is "TEST_DB"
    condition = fakewebservices_database.database.name == "TEST_DB"
    # Error message to display if condition is not met
    error_message = "incorrect database name"
  }

  assert {
    # Check if the size of the database is 128
    condition = fakewebservices_database.database.size == 128
    # Error message to display if condition is not met
    error_message = "incorrect database size"
  }
}