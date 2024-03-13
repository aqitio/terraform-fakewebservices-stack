check "check_fakewebservices_database_size" {
  assert {
    condition     = fakewebservices_database.database.size == 128
    error_message = format("All database resources should have a database size of '128'. Got %s instead.", fakewebservices_database.database.size)
  }
}

check "check_fakewebservices_server_type" {
  assert {
    condition     = alltrue([for server in fakewebservices_server.server: server.type == "t2.micro"])
    error_message = format("All server resources should have a type of 't2.micro'.")
  }
}
