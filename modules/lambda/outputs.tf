output "lambda_function_name" {
  value = aws_lambda_function.face_match.function_name
}

output "lambda_arn" {
  value = aws_lambda_function.face_match.arn
}
