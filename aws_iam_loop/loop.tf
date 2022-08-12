variable "joiners" {
type = list
default = ["user1","user2","user3"]
}

output "newJoiners" {
value = [for MYVAR in var.joiners : upper(MYVAR)]
}

resource "aws_iam_user" "usercreate" {
count = length(var.joiners)
name = var.joiners[count.index]
}

