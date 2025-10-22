# Changelog

Todos los cambios notables en este proyecto serán documentados en este archivo.

## [0.1.0] - 2025-10-22

### Added

* **feat(idp): Paquete inicial Ouroboros IDP (MVP)**
* Implementa el flujo canónico de alta de identidad en 2 pasos (`/register` y `/confirm`).
* Añade el endpoint de verificación `POST /verify` con la lógica de 5 pasos (h-chain, firma de sello, Merkle proof, firma de Ouroboros, policy replay).
* Integra `libsodium-wrappers` para la generación de claves Ed25519 (`gen-keys.ts`).
* Incluye script de *seeding* (`seed.sh`) para probar el alta completa.
* Añade worker asíncrono (stub) para *batching* de Merkle root y firma `ouro_root_t`.
* Define la especificación central (`openapi.yaml`, `events_schema.json`, `flow_alta.md`).
* Agrega tests de integración (`identity_flow.test.ts`) para el flujo completo.
