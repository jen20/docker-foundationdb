# `docker-foundationdb`

This repository contains the source files used to build the [`jen20/foundationdb`][image] image
available on Docker Hub.

The image is built using the [Packer][packer] builder for Docker, rather than a `Dockerfile`.

The image is intended for simplifying integration testing, _not_ for production use. If running
under Docker for Mac, please note that the default VM has 2GB of RAM, and FoundationDB issues a
warning if less than 4GB available. For low-volume integration testing I have not found this to be
an issue, and the machine started by Docker for Mac is easily resized via the preferences.

## Usage

To run a container based on the image, use: 

```
docker run jen20/foundationdb
```

The database engine is exposed on port 4500. The `fdbcli` client is included in the image, so if you
have a running container with the server, you can use `docker exec` to get a local client if you do
not have it available locally:

```
# Start server
docker run jen20/foundationdb

# Find container ID of server
docker exec -it $(docker ps -l -q) fdbcli
```

## Acknowledgements

This work is based on the work done by [Chr1st0ph][christoph] in the [`docker-foundationdb`][orig],
though it is anticipated that this will diverge beyond simply replacing the `Dockerfile` with Packer
as this image grows support for TLS in future.

Consequently, this repository is under the same MIT license as `Chr1st0ph/docker-foundationdb`.

[image]: https://hub.docker.com/r/jen20/foundationdb/
[packer]: https://www.packer.io/docs/builders/docker.html
[christoph]: https://github.com/Chr1st0ph
[orig]: https://github.com/Chr1st0ph/foundationdb-docker
