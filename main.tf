provider "aws" {
    region = "us-east-1"
}

variable "function_name" {
  default = "hello_lambda"
}

variable "handler" {
  default = "lambda.handler"
}

variable "runtime" {
  default = "python3.6"
}

variable "python_file_name" {
  default = "lambda.py"
}

variable "zip_file_name" {
  default = "lambda.zip"
}


data "archive_file" "test_lambda_code" {
  type = "zip"
  source_file = "${path.module}/${var.python_file_name}"
  output_path = "${path.module}/.terraform/archive_files/${var.zip_file_name}"
}

resource "aws_iam_role" "lambda_exec_role" {
  name        = "lambda_exec"
  path        = "/"
  description = "Allows Lambda Function to call AWS services on your behalf."
  assume_role_policy = "${file("${path.module}/assume_role_policy.json")}"
}

resource "aws_lambda_function" "lambda_function" {
  role             = "${aws_iam_role.lambda_exec_role.arn}"
  handler          = "${var.handler}"
  runtime          = "${var.runtime}"
  filename         = "${data.archive_file.test_lambda_code.output_path}"
  function_name    = "${var.function_name}"
  source_code_hash = "${base64sha256(file("${data.archive_file.test_lambda_code.output_path}"))}"
}