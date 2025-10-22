#!/usr/bin/env bash
set -euo pipefail

# =============================================================================
# seed.sh - Script de inicialización end-to-end para Aion Core IDP
# =============================================================================
# Flujo:
# 1. Genera claves Ed25519 (pk_root/dev_sk_root) como JSON
# 2. Registra identidad DID en /identities/register
# 3. Confirma identidad en /identities/{did}/confirm
# 4. Espera ciclo del worker (Merkle + firma ouro_root_t)
# 5. Obtiene proof en /identities/{did}/proofs
# 6. Verifica en /verify con shape alineado al contrato
# =============================================================================

BASE_URL=${BASE_URL:-http://localhost:3000}
DID=${DID:-did:key:z6MkiSeedDemo}

echo "========================================="
echo "🚀 Aion Core IDP - Seed End-to-End"
echo "========================================="
echo ""

# -----------------------------------------------------------------------------
# Paso 1: Generación de claves Ed25519 (JSON canónico)
# -----------------------------------------------------------------------------
echo "[seed] Generando claves (JSON)"
KEYS_JSON=$(npx ts-node scripts/gen-keys.ts)
PK_ROOT=$(echo "$KEYS_JSON" | jq -r .pk_root)
DEV_SK_ROOT=$(echo "$KEYS_JSON" | jq -r .dev_sk_root)

echo "✅ Claves generadas"
echo "   pk_root: $PK_ROOT"
echo ""

# -----------------------------------------------------------------------------
# Paso 2: Registro de identidad DID
# -----------------------------------------------------------------------------
echo "[seed] Registro /identities/register"
REG_RESP=$(curl -s -X POST "$BASE_URL/identities/register" \
  -H "Content-Type: application/json" \
  -d "$(jq -n --arg did "$DID" --arg pk "$PK_ROOT" --arg sk "$DEV_SK_ROOT" \
      --arg ts "$(date -Iseconds)" \
      '{did_proposal:$did, pk_root:$pk, dev_sk_root:$sk, h0:null, meta:{ts:$ts, client_ver:"seed-0.1"}}')")

echo "$REG_RESP" | jq .
DID_OUT=$(echo "$REG_RESP" | jq -r .did)
[ -z "$DID_OUT" ] && { echo "❌ did no retornado"; exit 1; }

echo ""

# -----------------------------------------------------------------------------
# Paso 3: Confirmación de identidad
# -----------------------------------------------------------------------------
echo "[seed] Confirm /identities/{did}/confirm"
CONFIRM_RESP=$(curl -s -X PUT "$BASE_URL/identities/$DID_OUT/confirm" \
  -H "Content-Type: application/json" \
  -d '{"challenge_sig":"base64:AAA=","device_attest":{"type":"local-signer","evidence":"base64:AAA="}}')

echo "$CONFIRM_RESP" | jq .

H0=$(echo "$CONFIRM_RESP" | jq -r .chain.h0)
H1=$(echo "$CONFIRM_RESP" | jq -r .chain.h1)

echo "✅ Identidad confirmada"
echo "   h0: $H0"
echo "   h1: $H1"
echo ""

# -----------------------------------------------------------------------------
# Paso 4: Esperar ciclo del worker (32s)
# -----------------------------------------------------------------------------
echo "⏳ Esperando worker (32s)..."
sleep 32

# -----------------------------------------------------------------------------
# Paso 5: Obtener proof
# -----------------------------------------------------------------------------
echo "[seed] Proofs /identities/{did}/proofs"
PROOF_RESP=$(curl -s "$BASE_URL/identities/$DID_OUT/proofs")
echo "$PROOF_RESP" | jq .

# Alinear con shape latest.*
MERKLE_PROOF=$(echo "$PROOF_RESP" | jq -c .latest.merkle_proof)
EPOCH=$(echo "$PROOF_RESP" | jq -r .latest.epoch_t)
OURO_ROOT_T=$(echo "$PROOF_RESP" | jq -r .latest.ouro_root_t)

echo "✅ Proof obtenido"
echo "   epoch: $EPOCH"
echo ""

# -----------------------------------------------------------------------------
# Paso 6: Verificación en /verify
# -----------------------------------------------------------------------------
echo "[seed] POST /verify"
VERIFY_BODY=$(jq -n \
  --arg did "$DID_OUT" \
  --arg pk_role "$PK_ROOT" \
  --arg h_prev "$H0" \
  --arg h_curr "$H1" \
  --arg sello "base64:AAA=" \
  --argjson merkle_proof "$MERKLE_PROOF" \
  --arg ouro "$OURO_ROOT_T" \
  --arg policy "initial_declaration_v1" \
  --arg decl "hex:decl" \
  --arg ts "$(date -Iseconds)" \
  '{did:$did, pk_role:$pk_role, h_prev:$h_prev, h_curr:$h_curr, sello:$sello,
    merkle_proof:$merkle_proof, ouro_root_t:$ouro, policy_id:$policy, declaration_hash:$decl, meta:{ts:$ts}}')

VERIFY_RESP=$(curl -s -X POST "$BASE_URL/verify" -H "Content-Type: application/json" -d "$VERIFY_BODY")
echo "$VERIFY_RESP" | jq .

OK=$(echo "$VERIFY_RESP" | jq -r .ok)

if [ "$OK" = "true" ]; then
  echo ""
  echo "========================================="
  echo "✅ VERIFICACIÓN EXITOSA"
  echo "========================================="
  echo ""
  echo "Todos los checks pasaron:"
  echo "$VERIFY_RESP" | jq '.checks'
else
  echo ""
  echo "========================================="
  echo "❌ VERIFICACIÓN FALLÓ"
  echo "========================================="
  echo ""
  echo "Detalles:"
  echo "$VERIFY_RESP" | jq '.'
  exit 1
fi
