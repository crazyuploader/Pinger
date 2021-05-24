# Pinger

> Run MTR every X minutes!

## Usage

Add IPs/Domains to `servers.txt` file and Run Script with -

```bash
./mtr.sh
```

## Docker Compose

Edit `.env` however you like to, and to finally run Pinger -

```bash
docker-compose up --build --detach
```

### Things Used

- [Alpine Docker](https://hub.docker.com/_/alpine)
- [Markserv - Markdown Server](https://github.com/markserv/markserv)
- [MTR](http://www.bitwizard.nl/mtr/)
