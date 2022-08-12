variable "attendance"{
type = bool
default = true
}


resource "null_resource" "operation1" {
   provisioner "local-exec" {
      command = "echo ${var.myvar} having ${var.newvar} members and saying as ${var.myvar1} > file1.txt"
   }
}


resource "null_resource" "operation2" {
   provisioner "local-exec" {
      command = "echo ${var.attendance} is the value of attendance variable > file1.txt"
   }
}

