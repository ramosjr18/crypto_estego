#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
ROOT_DIR="$( dirname "$SCRIPT_DIR" )"
OUT_DIR="$ROOT_DIR/outputs"

IDX="${1:-}"
if [[ -z "${IDX}" ]]; then
  echo "Usage: $0 <index: 1..10>"
  exit 1
fi
i=$(printf "%02d" "${IDX}")
MAN="${OUT_DIR}/q1_manifest.csv"
[[ -f "${MAN}" ]] || { echo "Manifest not found: ${MAN}"; exit 1; }

LINE="$(grep "^${i}," "${MAN}" || true)"
[[ -n "${LINE}" ]] || { echo "Index ${i} not found in manifest."; exit 1; }

IFS=',' read -r _idx _in _out _key_hex _iv_hex <<< "${LINE}"
DEC_OUT="${OUT_DIR}/file${i}.dec.txt"
openssl enc -d -aes-128-cbc -K "${_key_hex}" -iv "${_iv_hex}" -in "${_out}" -out "${DEC_OUT}"
echo "Decrypted -> ${DEC_OUT}"
