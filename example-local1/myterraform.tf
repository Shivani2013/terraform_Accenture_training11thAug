resource "null_resource" "opt1" {
  provisioner "local-exec" {
  command = "echo 'this is terraform training' > training.txt"
 }
}

resource "null_resource" "opt2" {
  provisioner "local-exec" {
  command = "echo 'this is shivi' >> training.txt"
 }
}

