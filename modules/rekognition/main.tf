
resource "aws_rekognition_collection" "collection" {
  collection_id = var.collection_id
}

output "collection_id" {
  value = aws_rekognition_collection.collection.collection_id
}
