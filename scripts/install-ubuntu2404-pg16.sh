#!/usr/bin/env bash
set -euo pipefail

if [ "$(id -u)" -ne 0 ]; then
  echo "Run as root: sudo bash $0"
  exit 1
fi

. /etc/os-release
if [ "${ID:-}" != "ubuntu" ] || [ "${VERSION_ID:-}" != "24.04" ]; then
  echo "WARNING: this script targets Ubuntu 24.04 LTS; detected ${PRETTY_NAME:-unknown}."
fi

apt-get update
apt-get install -y ca-certificates curl gnupg

install -d -m 0755 /usr/share/postgresql-common/pgdg
curl -fsSL https://www.postgresql.org/media/keys/ACCC4CF8.asc   -o /usr/share/postgresql-common/pgdg/apt.postgresql.org.asc

echo "deb [signed-by=/usr/share/postgresql-common/pgdg/apt.postgresql.org.asc] https://apt.postgresql.org/pub/repos/apt noble-pgdg main"   > /etc/apt/sources.list.d/pgdg.list

apt-get update
apt-get install -y postgresql-16 postgresql-client-16

systemctl enable --now postgresql
sudo -u postgres psql -Atqc "select version();"
echo "PostgreSQL 16 installation finished."
