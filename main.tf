terraform {
  backend "s3" {
    bucket         = "raspi-tf-state-colemchase"
    key            = "infra/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "random_id" "bucket" {
  byte_length = 4
}

module "s3" {
  source      = "./modules/s3"
  bucket_name = "raspi-face-images-${random_id.bucket.hex}"
}

module "rekognition" {
  source         = "./modules/rekognition"
  collection_id  = "raspi-user-faces"
}

module "iam" {
  source         = "./modules/iam"
  role_name      = "raspi-lambda-role"
  s3_arn_prefix  = "${module.s3.bucket_arn}/*"
}

module "lambda" {
  source         = "./modules/lambda"
  function_name  = "raspi-face-match"
  role_arn       = module.iam.role_arn
}

module "apigateway" {
  source     = "./modules/apigateway"
  api_name   = "raspi-face-api"
  lambda_arn = module.lambda.lambda_arn
}

output "bucket_name" {
  value = module.s3.bucket_name
}

output "collection_id" {
  value = module.rekognition.collection_id
}
