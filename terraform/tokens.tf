resource "aws_dynamodb_table" "access_tokens" {
  name         = "AccessTokens"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "token"

  attribute {
    name = "token"
    type = "S"
  }

  tags = {
    Purpose = "Capability-based access control"
  }
}
