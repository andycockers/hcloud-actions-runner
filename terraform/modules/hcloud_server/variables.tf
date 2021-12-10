variable "type"         {}
variable "server_type"  {}
variable "location"     {}
variable "network_id"   {}
variable "hcloud_token" {
  sensitive = true
}