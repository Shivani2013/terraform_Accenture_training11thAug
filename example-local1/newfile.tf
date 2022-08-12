
resource "null_resource" "opt3" {
  provisioner "local-exec" {
  command = "echo 'this is operation testing' >> training.txt"
 }
}
resource "null_resource" "opt5" {
  provisioner "local-exec" {
  command = "echo 'this is operation5 testing' >> training.txt"
 }
}

