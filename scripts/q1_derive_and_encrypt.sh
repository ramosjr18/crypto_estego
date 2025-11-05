#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
ROOT_DIR="$( dirname "$SCRIPT_DIR" )"
INPUT_DIR="$ROOT_DIR/samples"
OUT_DIR="$ROOT_DIR/outputs"
KEY_DIR="$ROOT_DIR/keys"

USERKEY_HEX_FILE="${1:-}"
if [[ -z "${USERKEY_HEX_FILE}" || ! -f "${USERKEY_HEX_FILE}" ]]; then
  echo "ERROR: Provide path to 128-bit hex key file. Example: keys/userkey.hex"
  exit 1
fi
USERKEY_HEX="$(tr -d '\n\r ' < "${USERKEY_HEX_FILE}")"
if [[ ${#USERKEY_HEX} -ne 32 ]]; then
  echo "ERROR: key must be 32 hex chars (128 bits). Got ${#USERKEY_HEX} chars."
  exit 1
fi

mkdir -p "$OUT_DIR" "$KEY_DIR"
: > "${OUT_DIR}/q1_manifest.csv"
echo "index,input_file,cipher_file,key_hex,iv_hex" >> "${OUT_DIR}/q1_manifest.csv"

# Derive 10 keys via HMAC-SHA256(user_key, info="file-i"), take first 16 bytes (128-bit)
for i in $(seq -w 1 10); do
  INFO="file-${i}"
  # HMAC-SHA256 in binary, then take 16 bytes
  openssl dgst -sha256 -mac HMAC -macopt hexkey:"${USERKEY_HEX}" -binary <<<"${INFO}" \
    | head -c 16 > "${KEY_DIR}/key_${i}.bin"
  xxd -p -c 32 "${KEY_DIR}/key_${i}.bin" > "${KEY_DIR}/key_${i}.hex"
done

# Encrypt 10 files with random IV (16 bytes)
index=1
for f in $(ls -1 "${INPUT_DIR}"/file*.txt 2>/dev/null | head -n 10); do
  i=$(printf "%02d" "${index}")
  KEY_HEX="$(cat "${KEY_DIR}/key_${i}.hex")"
  IV_HEX="$(openssl rand -hex 16)"
  OUT_FILE="${OUT_DIR}/file${i}.enc"
  openssl enc -aes-128-cbc -K "${KEY_HEX}" -iv "${IV_HEX}" -in "${f}" -out "${OUT_FILE}"
  echo "${i},${f},${OUT_FILE},${KEY_HEX},${IV_HEX}" >> "${OUT_DIR}/q1_manifest.csv"
  index=$((index+1))
done

echo "DONE. Manifest: ${OUT_DIR}/q1_manifest.csv"
