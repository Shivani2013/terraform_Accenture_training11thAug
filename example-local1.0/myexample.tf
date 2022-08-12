resource "null_resource" "newOperation" {
provisioner "local-exec"{
  command = "echo $ENV1 $ENV2 $ENV3 >> myenv.txt"
  environment = {
    ENV1 = "Training"
    ENV2 = "true"
    ENV3 = 1
}
}
}

