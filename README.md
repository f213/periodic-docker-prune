# Peridic docker prune

![head](https://user-images.githubusercontent.com/1592663/54130596-b737ae80-4421-11e9-9b89-aa8b8da06dd7.jpg)


## The problem
When running a swarm, periodicaly updating service images, each work holds stale versions of this images, taking space.

Common solution is to run `docker prune` in the crontab, but we do not want to configure our workers besides joining to the swarm, aren't
we?

So this image is designed for running with zero host configuration.

## Swarm

```yaml
version: '3.6'

services:
  periodic-prune:
    image: f213/periodic-docker-prune
        
    # may be omitted, 05:24 by default
    environment:
      AT: '05:44'

    deploy:
      mode: global
      
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock
      
```

## Manual

```sh
$ docker run -ti -v "/var/run/docker.sock:/var/run/docker.sock" -e AT='17:20' f213/periodic-docker-prune
```
