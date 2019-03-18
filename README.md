# Periodic docker prune

[![](https://images.microbadger.com/badges/image/f213/periodic-docker-prune.svg)](https://microbadger.com/images/f213/periodic-docker-prune "Get your own image badge on microbadger.com")
![](https://img.shields.io/docker/cloud/automated/f213/periodic-docker-prune.svg)

![head](https://user-images.githubusercontent.com/1592663/54130596-b737ae80-4421-11e9-9b89-aa8b8da06dd7.jpg)


## The problem
When running a swarm, periodicaly updating service images, each worker node starts to hold stale versions of old images, taking disk space.

Common solution is to run `docker prune` via cron, but we do not want to configure our workers besides joining to the swarm, aren't we?

So this image is designed for running periodic system clean with zero host configuration.

## Swarm

```yaml
version: '3.6'

services:
  periodic-prune:
    image: f213/periodic-docker-prune:1.1.0
        
    # may be omitted, 05:24 by default
    environment:
      AT: '02:44'

    deploy:
      mode: global
      
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock
      
```

## Manual

```sh
$ docker run -v "/var/run/docker.sock:/var/run/docker.sock" -e AT='17:20' f213/periodic-docker-prune
```
