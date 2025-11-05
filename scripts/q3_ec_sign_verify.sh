#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
ROOT_DIR="$( dirname "$SCRIPT_DIR" )"
KEY_DIR="$ROOT_DIR/keys"

IN="${1:-}"
if [[ -z "${IN}" || ! -f "${IN}" ]]; then
  echo "Usage: $0 <file_to_sign>"
  exit 1
fi

mkdir -p "$KEY_DIR"
PRIV="$KEY_DIR/ec_private.pem"
PUB="$KEY_DIR/ec_public.pem"
SIG="${IN}.sig"

# EC keypair
openssl ecparam -name prime256v1 -genkey -noout -out "${PRIV}"
openssl ec -in "${PRIV}" -pubout -out "${PUB}"

# Sign & verify
openssl dgst -sha256 -sign "${PRIV}" -out "${SIG}" "${IN}"
openssl dgst -sha256 -verify "${PUB}" -signature "${SIG}" "${IN}"

echo "Keys: ${PRIV} / ${PUB}"
echo "Signature: ${SIG} (DER)"
echo "Verification OK"
