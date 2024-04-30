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


/*

Error should get if tf lock file in place -
----------------
vijay@vijay-HP-Pavilion-g4-Notebook-PC:~/terraform-lab/ot
/others/s3-state-locking$ terraform plan
Acquiring state lock. This may take a few moments...
╷
│ Error: Error acquiring the state lock
│ 
│ Error message: operation error DynamoDB: PutItem,
│ https response error StatusCode: 400, RequestID:
│ NOV3A1886OKPM6QUSBCVHDIMQ3VV4KQNSO5AEMVJF66Q9ASUAAJG,
│ ConditionalCheckFailedException: The conditional
│ request failed
│ Lock Info:
│   ID:        65a2541f-e247-5dbf-0b20-886d886063af
│   Path:      tf-backend-001-s3/pprod-tf-state-logs/terraform.tfstate
│   Operation: OperationTypeApply
│   Who:       vijay@vijay-HP-Pavilion-g4-Notebook-PC
│   Version:   1.8.2
│   Created:   2024-04-30 18:48:29.091467995 +0000 UTC
│   Info:      
│ 
│ 
│ Terraform acquires a state lock to protect the state
│ from being written
│ by multiple users at the same time. Please resolve the
│ issue above and try
│ again. For most commands, you can disable locking with
│ the "-lock=false"
│ flag, but this is not recommended.
╵
vijay@vijay-HP-Pavilion-g4-Notebook-PC:~/terraform-lab/others/s3-state-locking$ 

*/