variable "type"         {
  type = string
  default = "value=value"
}
variable "server_type"  {
  type = string
  default = "value"
}
variable "location"     {
  type = string
  default = "value"
}
variable "network_id"   {
  type = string
  default = "value"
}
variable "runner_home"  {
  type = string
  default = "value"
}
variable "runner_user"  {
  type = string
  default = "value"
}
variable "extra_flags"  {
  type = string
  default = "value"
}
variable "gh_repo"      {
  type = string
  default = "value"
}
variable "runner_token" {
  type = string
  default = "value"
}
variable "hcloud_token" {
  sensitive = true
}