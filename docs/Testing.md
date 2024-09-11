# Testing
Before running this playbook on real hardware it may be a good idea to test and understand it on a testing environment. This document aims to give indications has how such an test environment was used during development and how to replicate it.

## Virtual Machine setup
Easiest way to get started is with a Virtual Machine (VM), in our case QEMU/KVM with virt manager was used but any one that can run a Debian 12 install should be good (ex : [Virtualbox](https://www.virtualbox.org/), [VmWare](https://support.broadcom.com/group/ecx/productdownloads?subfamily=VMware+Workstation+Pro), ...).

### System install
Create a new VM from a debian image, set up SSH access from your host.

### Test devices
Installation will fail on start if the bridge can not find the configured device, in order to emulate those install and run the [H2F_test_devices](https://github.com/lkzjdnb/H2F_test_devices) project.

### Configuration
Add your test device to [inventory/hosts](/inventory/hosts) with the local IP address of your VM, ex : 

`https://github.com/lkzjdnb/H2F_test_devices`

Create the associated configuration. Make sure to add the `bridge_test_environment` variable to true, this will add access to the emulated devices and redirect calls to foreign IPs (ex : 192.168.1.12 and 192.168.1.16) to localhost.

```yaml
---
folder: station_control
domain: H2F

influx_pass: DHBW2024

influx_migrate_file:
  - export.lp

bridge_test_environment: true
```

### Running the playbook
You can then run the playbook as usual : 

`ansible-playbook -v -i inventory/hosts playbook.yaml --tags "install-all"`

### Accessing the interface
Depending on graphics support of the VM, the interface may be accessible.
Otherwise you can access it directly on the host : 
- Add the hostname to your host registry (/etc/hosts on linux):
```diff
# Static table lookup for hostnames.
# See hosts(5) for details.

127.0.0.1	localhost
::1		localhost
+<VM ip> webui.h2f
+<VM ip> grafana.h2f
+<VM ip> influx.h2f
```
Replacing <VM ip> with the local IP adress of your VM.

It should now possible to access the interface from the host at http://webui.h2f.
