data "archive_file" "lambda_zip" {
  type        = "zip"
  source_dir  = "${path.module}/lambda_src"
  output_path = "${path.module}/lambda.zip"
}

resource "aws_lambda_function" "face_match" {
  function_name = var.function_name
  role          = var.role_arn
  handler       = "handler.lambda_handler"
  runtime       = "python3.11"
  timeout       = 10
  memory_size   = 128

  filename         = data.archive_file.lambda_zip.output_path
  source_code_hash = data.archive_file.lambda_zip.output_base64sha256
}
