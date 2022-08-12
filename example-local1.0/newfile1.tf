resource "null_resource" "runningScript" {
provisioner "local-exec" {
command = "sh myscript.sh"
working_dir = "/tmp"
}
}

