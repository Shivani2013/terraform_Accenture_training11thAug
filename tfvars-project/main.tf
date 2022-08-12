resource "null_resource" "operation23" {
provisioner "local-exec" {
  command = "echo values of myvar is ${var.myvar} and  variable yourvar is ${var.yourvar} >> out1.txt"
}
}

