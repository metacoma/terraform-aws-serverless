resource "aws_dynamodb_table" "courses-dynamo" {
    name = "Invites"
    read_capacity = 20
    write_capacity = 20
    hash_key = "InviteId"
    range_key = "Email"
    attribute {
      name = "InviteId"
      type = "S"
    }
    attribute {
      name = "Email"
      type = "S"
    }
}


data "aws_iam_policy_document" "lambda_modify_table" {
  statement {
    effect = "Allow"

    actions = [
      "dynamodb:PutItem",
    ]

    resources = [
      "${aws_dynamodb_table.courses-dynamo.arn}",
    ]
  }
}
/*
resource "aws_iam_role" "courses-dynamo" {
  name               = "course-dynamo"
  assume_role_policy = "${data.aws_iam_policy_document.lambda_modify_table.json}"
}

output "aws iam policy document" {
  value = "${data.aws_iam_policy_document.lambda_modify_table.json}"
}


resource "aws_iam_role_policy" "lambda_modify_table" {
  name   = "DynamoDBAppModifyTablePolicy"
  role   = "${aws_iam_role.courses-dynamo.id}"
  policy = "${data.aws_iam_policy_document.lambda_modify_table.json}"
}

*/

