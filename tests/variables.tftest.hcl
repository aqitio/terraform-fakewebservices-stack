# Define variables
variables {
  # Define the hostname for the Fake Web Services provider
  fws_hostname = "app.terraform.io"
}

# Configure the Fake Web Services provider
provider "fakewebservices" {
  # Set the hostname for the provider to the value of the fws_hostname variable
  hostname = var.fws_hostname
  # Set the token for the provider to the value of the fake_token variable
  token    = var.fake_token
}

# Define a Terraform Cloud run with variable validations
run "variables_validation" {
  # Define variables to be used in the run
  variables {
    # Define the stack prefix variable
    stack_prefix   = "test"
    # Define the server count variable
    server_count   = 1
    # Define the server type variable
    server_type    = "t2.micro"
    # Define the database size variable
    database_size  = 128
    # Define the VPC CIDR block variable
    vpc_cidr_block = "10.0.0.0/16"
  }

  # Assert conditions for variable validations
  assert {
    # Check if the stack_prefix variable equals "test"
    condition     = var.stack_prefix == "test"
    # Error message to display if condition is not met
    error_message = "incorrect value for stack_prefix"
  }

  assert {
    # Check if the server_count variable equals 1
    condition     = var.server_count == 1
    # Error message to display if condition is not met
    error_message = "incorrect value for server_count"
  }

  assert {
    # Check if the server_type variable equals "t2.micro"
    condition     = var.server_type == "t2.micro"
    # Error message to display if condition is not met
    error_message = "incorrect value for server_type"
  }

  assert {
    # Check if the database_size variable equals 128
    condition     = var.database_size == 128
    # Error message to display if condition is not met
    error_message = "incorrect value for database_size"
  }

  assert {
    # Check if the vpc_cidr_block variable equals "10.0.0.0/16"
    condition     = var.vpc_cidr_block == "10.0.0.0/16"
    # Error message to display if condition is not met
    error_message = "incorrect value for vpc_cidr_block"
  }
}
