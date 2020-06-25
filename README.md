# EdgeRouter VPN Watchdog

A couple of scripts for watching my VPN connections on an EdgeRouter. Tested on my Ubiquiti EdgeRouter Infinity running EdgeOS 2.0.8.

## Installation

Copy the scripts to /config/scripts/.

Setup task-scheduler (crontab), mine looks like this:
```bash
configure
show system task-scheduler 
```

```
 task vpn_check {
     crontab-spec "55 * * * *"
     executable {
         path /config/scripts/check_vpn.sh
     }
 }
```
## Usage

Edit vpn_reset.sh, change the vtun interfaces to match yours.

This is what my VPN definitions look like:
```bash
configure
show interfaces openvpn
```

```
 openvpn vtun1 {
     config-file /config/auth/myvpn/myvpn_us-la_udp.ovpn
     description "MyVPN - US LA (UDP)"
 }
 openvpn vtun2 {
     config-file /config/auth/thevpn/thevpn_eu-frankfurt_tcp.ovpn
     description "TheVPN - EU Frankfurt (TCP)"
 }
```

## Contributing

Pull requests welcome.

## Authors

* **Alvin Jiang**

## License

This project is licensed under the [MIT](https://choosealicense.com/licenses/mit/) License.
