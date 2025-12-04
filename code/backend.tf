# Backend Storage

terraform {
	backend "s3"

	bucket  =  "terraform3020"
	key     =  "terraform/backend"
	region  =  "us-east-2"
}
