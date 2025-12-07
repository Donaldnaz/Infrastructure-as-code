variable "project" {
  description = "The project to deploy"
  default     = ""
}

variable "region" {
  description = "Region for cloud resources"
  default     = "us-central1"
}

variable "database_version" {
  description = "The version of of the database"
  default     = "MYSQL_5_6"
}

variable "master_instance_name" {
  description = "The name of the master instance to replicate"
  default     = ""
}

variable "tier" {
  description = "The machine tier"
  default     = "db-f1-micro"
}

variable "db_name" {
  description = "default database to create"
  default     = "default"
}

variable "db_charset" {
  description = "The charset for the default database"
  default     = ""
}

variable "db_collation" {
  description = "The collation for the default database."
  default     = ""
}

variable "user_name" {
  description = "The name of the default user"
  default     = "default"
}

variable "user_host" {
  description = "The host for the default user"
  default     = "%"
}

variable "user_password" {
  description = "The password for the default user."
  default     = ""
}

variable "activation_policy" {
  description = "This specifies when the instance should be active."
  default     = "ALWAYS"
}

variable "authorized_gae_applications" {
  description = "A list of Google App Engine"
  default     = []
}

variable "disk_autoresize" {
  description = "Second Generation only. Configuration to increase storage size automatically"
  default     = true
}

variable "disk_size" {
  description = "Second generation only"
  default     = 10
}

variable "disk_type" {
  description = "Second generation only"
  default     = "PD_SSD"
}

variable "pricing_plan" {
  description = "First generation only"
  default     = "PER_USE"
}

variable "replication_type" {
  description = "Replication type for this instance"
  default     = "SYNCHRONOUS"
}

variable "database_flags" {
  description = "List of Cloud SQL flags that are applied to the database server"
  default     = []
}

variable "backup_configuration" {
  description = "The backup_configuration settings subblock for the database setings"
  default     = {}
}

variable "ip_configuration" {
  description = "The ip_configuration settings subblock"
  default     = {}
}

variable "location_preference" {
  description = "The location_preference settings subblock"
  default     = {}
}

variable "maintenance_window" {
  description = "The maintenance_window settings subblock"
  default     = {}
}

variable "replica_configuration" {
  description = "The optional replica_configuration block for the database instance"
  default     = {}
}

variable "availability_type" {
  description = "This specifies whether a PostgreSQL instance should be set up for high availability (REGIONAL) or single zone (ZONAL)."
  default     = "ZONAL"
}


