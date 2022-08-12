resource "null_resource" "operation1" {
        provisioner "local-exec" {
        command = "echo 'Hello all this is shivani' > file2.txt"
}
}

