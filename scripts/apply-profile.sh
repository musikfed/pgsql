#!/usr/bin/env bash
set -euo pipefail

PROFILE="${1:-}"
case "$PROFILE" in
  1c) SRC="configs/postgresql/1c-enterprise.conf" ;;
  web) SRC="configs/postgresql/web.conf" ;;
  rib) SRC="configs/postgresql/rib.conf" ;;
  common) SRC="configs/postgresql/common-16gb.conf" ;;
  *) echo "Usage: sudo bash $0 {common|1c|web|rib}"; exit 2 ;;
esac

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
SRC="$ROOT/$SRC"
DST_DIR="/etc/postgresql/16/main/conf.d"
MAIN="/etc/postgresql/16/main/postgresql.conf"

[ -f "$SRC" ] || { echo "Missing $SRC"; exit 1; }
install -d -m 0755 "$DST_DIR"
install -m 0644 "$SRC" "$DST_DIR/90-pgsql-lab-$PROFILE.conf"

if ! grep -Eq "^[[:space:]]*include_dir[[:space:]]*=[[:space:]]*'conf.d'" "$MAIN"; then
  printf "\ninclude_dir = 'conf.d'\n" >> "$MAIN"
fi

sudo -u postgres /usr/lib/postgresql/16/bin/postgres   -D /var/lib/postgresql/16/main   -C config_file >/dev/null

systemctl reload postgresql
echo "Applied profile: $PROFILE"
echo "Review effective values with: sudo -u postgres psql -c 'show all;'"
