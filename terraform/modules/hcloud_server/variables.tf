variable "type"         {}
variable "server_type"  {}
variable "location"     {}
variable "network_id"   {}
variable "runner_home"  {}
variable "runner_user"  {}
variable "extra_flags"  {}
variable "hcloud_token" {
  sensitive = true
}