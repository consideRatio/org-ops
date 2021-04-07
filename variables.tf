variable "project_id" {
  default = "two-eye-two-see-org"
}

variable "org_id" {
  default = 184174754493
}

variable "region" {
  default = "us-central1"
}

variable "fully_managed_projects" {
  type = map(string)
}

variable "managed_projects" {
  type = list(any)
}

variable "project_owners" {
  type = list(any)
  default = [
    "user:yuvipanda@2i2c.org",
    "user:georgianaelena@2i2c.org",
    "user:choldgraf@2i2c.org",
    "user:damianavila@2i2c.org",
    "user:erik@2i2c.org"
  ]
}
