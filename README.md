# mt-plugin-yum-update

## Installation (AWS)
* Copy plugin files.
* Execute the following command once.
  * sudo sh -c "echo 'www ALL=(ALL) NOPASSWD:/usr/bin/yum' >> /etc/sudoers.d/cloud-init"
* Restart EC2 instance.
