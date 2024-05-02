terraform {
  backend "s3" {
    bucket = "tf-backend-001-s3"
    key    = "prod-tf-state-logs/terraform.tfstate"
    region = "us-east-2"
    
    #configuation for s3 state locking with dynamoDB
    dynamodb_table = "tf-state-lock"
  }
}

resource "time_sleep" "ts_75_sec" {
  create_duration = "75s"
}


