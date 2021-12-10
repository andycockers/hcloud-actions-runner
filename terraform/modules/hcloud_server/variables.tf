variable "type"         {
  type = string
  nullable = true
}
variable "server_type"  {
  type = string
  nullable = true
}
variable "location"     {
  type = string
  nullable = true
}
variable "network_id"   {
  type = string
  nullable = true
}
variable "runner_home"  {
  type = string
  nullable = true
}
variable "runner_user"  {
  type = string
  nullable = true
}
variable "extra_flags"  {
  type = string
  nullable = true
}
variable "gh_repo"      {
  type = string
  nullable = true
}
variable "runner_token" {
  type = string
  nullable = true
}
variable "hcloud_token" {
  sensitive = true
  type = string
  nullable = false
}