#!/usr/bin/env bash

set -o errexit
set -o pipefail
set -o xtrace

export DEBIAN_FRONTEND=noninteractive

if [ -z "${FOUNDATIONDB_VERSION}" ] ; then
    echo "FOUNDATIONDB_VERSION must be set"
    exit 1
fi

if [ -z "${FOUNDATIONDB_REVISION}" ] ; then
    echo "FOUNDATIONDB_REVISION must be set"
    exit 1
fi

base_url="https://www.foundationdb.org/downloads/${FOUNDATIONDB_VERSION}/ubuntu/installers"

client_url="${base_url}/foundationdb-clients_${FOUNDATIONDB_VERSION}-${FOUNDATIONDB_REVISION}_amd64.deb"
server_url="${base_url}/foundationdb-server_${FOUNDATIONDB_VERSION}-${FOUNDATIONDB_REVISION}_amd64.deb"

apt-get update
apt-get install -y \
    dpkg \
    net-tools \
    python \
    wget \

wget -O /tmp/fdb-clients.deb \
    "${client_url}"

wget -O /tmp/fdb-server.deb  \
    "${server_url}"

dpkg --install /tmp/fdb-clients.deb /tmp/fdb-server.deb

apt-get remove --purge -y \
    wget

mv /tmp/start-foundationdb.sh /usr/local/bin/start-foundationdb.sh
chmod 755 /usr/local/bin/start-foundationdb.sh
