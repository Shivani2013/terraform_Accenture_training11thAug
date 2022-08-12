variable "myregion" {
   type = string
   default = "us-east-1"
 }

variable "aminame" {
 type = map
 default = {
 us-east-1 = "ami-06640050dc3f556bb"   ## rhel8
 us-west-1 = "ami-090fa75af13c156b4"   ## Amazon linux
}
}

