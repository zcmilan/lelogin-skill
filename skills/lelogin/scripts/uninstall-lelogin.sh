#!/usr/bin/env bash
set -euo pipefail
base_url="${LELOGIN_INSTALL_BASE_URL:-https://lelogin.nationauth.cn/lelogin/cmd}"
case "$base_url" in https://*) ;; *) echo "LeLogin uninstaller requires an HTTPS origin" >&2; exit 1 ;; esac
tmp="$(mktemp "${TMPDIR:-/tmp}/uninstall-lelogin.XXXXXX.sh")"
trap 'rm -f "$tmp"' EXIT
curl -fsSL "${base_url%/}/uninstall-lelogin.sh" -o "$tmp"
checksums="$(curl -fsSL "${base_url%/}/SHA256SUMS")"
expected="$(printf '%s\n' "$checksums" | awk '$2 == "uninstall-lelogin.sh" || $2 == "*uninstall-lelogin.sh" {print $1; exit}')"
[ -n "$expected" ] || { echo "uninstall-lelogin.sh is absent from SHA256SUMS" >&2; exit 1; }
if command -v shasum >/dev/null 2>&1; then actual="$(shasum -a 256 "$tmp" | awk '{print $1}')"; else actual="$(sha256sum "$tmp" | awk '{print $1}')"; fi
[ "$actual" = "$expected" ] || { echo "Uninstaller checksum mismatch" >&2; exit 1; }
bash "$tmp" "$@"
