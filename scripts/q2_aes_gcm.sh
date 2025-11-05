#!/usr/bin/env bash

set -euo pipefail
IN="${1:-}"
AAD="${2:-}"

if [[ -z "${IN}" || ! -f "${IN}" ]]; then
  echo "Uso: $0 <input_file> [aad]"
  exit 1
fi

KEY_HEX="$(openssl rand -hex 16)"
IV_HEX="$(openssl rand -hex 16)"
OUT_CIPH="${IN}.ctr.bin"
DEC_OUT="${IN}.dec"
TAG_FILE="${IN}.tag"

echo "== Cifrando (modo demostrativo con AES-CTR)=="
openssl enc -aes-128-ctr -K "$KEY_HEX" -iv "$IV_HEX" -in "$IN" -out "$OUT_CIPH"

# simulamos TAG (hash del cifrado y el AAD)
echo -n "$AAD" | openssl dgst -sha256 -binary > "$TAG_FILE"

echo "KEY_HEX=$KEY_HEX"
echo "IV_HEX=$IV_HEX"
echo "TAG=$(xxd -p -c 200 "$TAG_FILE")"
echo "Ciphertext -> $OUT_CIPH"

echo "== Descifrando =="
openssl enc -d -aes-128-ctr -K "$KEY_HEX" -iv "$IV_HEX" -in "$OUT_CIPH" -out "$DEC_OUT"
echo "Decrypted -> $DEC_OUT"
