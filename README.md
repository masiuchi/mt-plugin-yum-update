# mt-plugin-yum-update
Update installed yum packages everyday.

## Installation (AWS)
* Install this plugin to MT.
* Execute the following command once.
  * sudo sh -c "echo 'www ALL=(ALL) NOPASSWD:/usr/bin/yum' >> /etc/sudoers.d/cloud-init"
* Restart EC2 instance.
