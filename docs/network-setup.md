# Network setup
The network installation is outside the scope of this playbook and should be configured according to your how setup. The aim of this document is only to provide hints as the required setup and the tools that can be used. This should not be a source of truth, do it however you want.

## WiFi configuration
In order to push data to distant remote you need internet access, an easy way to set this up is using [NetworkManager](https://wiki.debian.org/NetworkManager). If not already installed, install it : 

`sudo apt-get install network-manager`

And then run the TUI (Terminal User Interface) : 
`nmtui`

You should be presented with an interface, interaction is done with the Arrow Keys, Tab, Space and Return.

To add a new wifi network : 
`Edit Connection > Add > Wi-Fi`

> For normal Wi-Fi select Security = "WPA and WPA2 Personal", SSID = [Your wifi name], Password = [Your wifi psk].
> For Eduroam choose Security = "WPA and WPA2 Entreprise", Authentification = "PEAP", Anonymous identity = "anonymous@student.dhbw-mannheim.de", PEAP version = "Automatic", Inner Authentification = "MSCHAPv2", Username = [your email ([studid]@student.dhbw-mannheim.de)], Password = [your password].

`Save > Go back > Activate a connection > Select your connexion > Activate`

## Ethernet configuration
Recommanded setup is to separate your system on a local network and only give outside access to push to the remotes. This can be done by connecting all devices on a switch with the server.
Easiest setup is simply to give static IPs to all your devices and this server (for example in the range 192.168.1.0/24) : 

- For the devices check the manufacturer instructions.
- For this server you can once again use nmtui : 

`nmtui`

`Edit Connection > Add > Ethernet`

IPv4 Configuration = "Manual"
Addresses = [A free ip in your range : ex "192.168.1.3/24"]
Never use this network for default route = "[X]" // To make sure that communication to the outside is done with WiFi

## Access to USB devices
Mount USB device to a permanent path, add a file named `10-rtumodbus.rules` to `/etc/udev/rules.d` with content : 
```udev
ACTION=="add", ATTRS{idVendor}=="0403", ATTRS{idProduct}=="6001", SYMLINK+="modbus_rtu"
```
Replacing the Ids with the value given by `lsusb` for your device and the symlink with the needed mountpoint.

> TODO: This may not be necessary because the docker deamon run as root ?

To access devices connected with USB (ex: ModBus RTU) you need proper authorization, on Debian this can be done by adding your user to the dialout group : 

`sudo usermod -a -G dialout <your user>`

> :warning: Groups are only reloaded on login, you therefore have to log-out and back. Or just reboot before these take effect.
