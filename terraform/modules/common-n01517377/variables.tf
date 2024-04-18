variable "resource_group_name" {}

variable "location" {}

variable  "common_tags" {}

variable "log_analytics_workspace_name" {
 default = "n01517377-log-analysis-workspace"
}

variable "recovery_services_vault_name" {
 default = "Vaultn01517377"
}

variable "storage_account_name" {
 default = "n01517377storageaccnew"
}
