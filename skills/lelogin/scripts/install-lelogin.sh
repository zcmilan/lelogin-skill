#!/usr/bin/env bash
set -euo pipefail

INSTALL_URL="${LELOGIN_INSTALL_BASE_URL:-https://lelogin.nationauth.cn/lelogin/cmd}"
case "$INSTALL_URL" in https://*) ;; *) echo "LeLogin installer requires an HTTPS origin" >&2; exit 1 ;; esac
tmp_dir="$(mktemp -d "${TMPDIR:-/tmp}/lelogin-installer.XXXXXX")"
trap 'rm -rf "$tmp_dir"' EXIT
curl -fsSL "${INSTALL_URL%/}/install-lelogin.sh" -o "$tmp_dir/install-lelogin.sh"
curl -fsSL "${INSTALL_URL%/}/SHA256SUMS" -o "$tmp_dir/SHA256SUMS"
expected="$(awk '$2 == "install-lelogin.sh" || $2 == "*install-lelogin.sh" { print $1; exit }' "$tmp_dir/SHA256SUMS")"
[ -n "$expected" ] || { echo "install-lelogin.sh is absent from SHA256SUMS" >&2; exit 1; }
if command -v shasum >/dev/null 2>&1; then actual="$(shasum -a 256 "$tmp_dir/install-lelogin.sh" | awk '{print $1}')"; else actual="$(sha256sum "$tmp_dir/install-lelogin.sh" | awk '{print $1}')"; fi
[ "$actual" = "$expected" ] || { echo "Installer checksum mismatch" >&2; exit 1; }
LELOGIN_INSTALL_BASE_URL="$INSTALL_URL" LELOGIN_SKIP_AGENT_SKILL=1 bash "$tmp_dir/install-lelogin.sh"
installed_cli="${LELOGIN_INSTALL_DIR:-$HOME/.local/bin}/lelogin"
"$installed_cli" --help
"$installed_cli" runtime status
