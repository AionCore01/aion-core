# Identidad Digital — Especificación mínima

## DID esquema

- Método inicial: `did:key` (prototipo)
- Futuro: `did:web` para legibilidad humana
- Anclaje on-chain: posterior, vía ancla de releases firmadas

## Algoritmo de firma

- Ed25519 (recomendado)
- Requisitos: claves rotables, almacenamiento seguro, firmas verificables en CI

## Roles y reclamos

- sanador: { nombre, linaje, nivel, certificaciones[] }
- tutor: { authority_id, scope, expiry }
- observador: { scope_read, reporting_duties }

## KYC/KYB (pilot mínimo)

- Verificación liviana manual + attestations firmadas por guardian
- Registro de evidencias fuera de cadena + hash canónico en release

## Revocación

- CRL pública + lista on-chain opcional en hitos
