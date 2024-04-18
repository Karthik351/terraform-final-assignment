resource "null_resource" "ansible" {
  provisioner "local-exec" {
    command = " cd ../ansible && /bin/bash script.sh"
  }
  depends_on = [
    module.rgroup-n01517377,
    module.datadisk-n01517377,
    module.vmlinux-n01517377
  ]
}
