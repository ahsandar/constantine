
# Constantine
![Constanine](constantine.jpeg)

Ad blocking VPN with DNS over HTTPS using cloudflared + pihole +  WireGuard. Currently running on a Raspberry Pi 4

# Pi hole
## VARS

```
export TZ=<set value> # set timezone for your origin for e.g. Asia/Singapore
export WEBPASSWORD=<set value> # set password for pi hole dashboard
export DNS1=<set value> # set to the docker IP assigned to cloudflared
export DNS2=<set value> # set any public DNS Quad9 Cloudflare Google OpenDNS
```

# Cloudflared
## VARS

```
export CLOUDFLARED_DNS1=<set value> # set any public DNS Quad9 Cloudflare Google OpenDNS
export CLOUDFLARED_DNS2=<set value> # set any public DNS Quad9 Cloudflare Google OpenDNS
```

# WireGuard
## VARS

```
export PEERS=<set value> #total number of peers
export PUID=<set value> # find usinng -> id <username>
export PGID=<set value> # find usinng -> id <username>
```

# To run

### Turn off local resolver

Use the script `local_resolver_stop.sh`

> `./local_resolver_stop.sh`

If you stop the containers, local resolver will need to be started to have your device be able to connect to internet use the script `local_resolver_start.sh`

> `./local_resolver_start.sh`



## Build containers

After turning off you system resolver make sure you have your variables set before building the containers.

> `docker-compose build`

## Start container

> `docker-compose up`

or  if you want to run in background

> `docker-compose up -d` 

If you want to set it up as a systemd service use the `docker-compose@.service` file and place it in `/etc/systemd/system/` and update the `WorkingDirectory`

Then you can start and stop it as such

> `systemctl start docker-compose@constantine`

> `systemctl stop docker-compose@constantine`


## WireGuard QR Codes

To find out QR Codes to setup the clients use

> `docker-compose logs -f wireguard`

also they are stored under the docker volume `constantine_wireguard_data` along with the conf and are most likely stored in a similar path

> `/var/lib/docker/volumes/constantine_wireguard_data/_data/`

## WireGuard connections

To look for the active connections can monitor the `wg show` 

> `docker exec -it constantine_wireguard_1 wg show`


# Port Forwarding

On your router remember to forward the port you have mapped on your device to the `WireGuard` container. In the project `docker-compose.yml` port mapping is set as `52828:51820` which means `device` port `52828` is mapped to `WireGuard` container port `51820`. So on your router make sure you forward port `52828` to your deivce's IP address to route all incoming traffic on your public IP via the router to the device running `WireGuard`.

