# AION-λ — Patch Notes v${MAJOR.MINOR.PATCH}-p${NN}

Fecha: <mention-date start="YYYY-MM-DD"/>
Commit/branch objetivo: <SHA|refs/heads/*>
Ambientes objetivo: staging | prod
Ventana de mantenimiento: <si aplica>

## TL;DR
- 1–2 líneas sobre el problema que corrige y el impacto.

## Cambios
- fix: …
- perf: …
- docs: …

## Seguridad
- ¿Afecta seguridad?: Sí | No
- Advisory relacionado: #<id> / AION-λ-SA-${YYYY}-${NN} | N/A

## Verificación rápida

```bash
shasum -a 256 -c checksums.txt
aion verify --leaf 0x<hash> --root 0x<root> --proof ./proofs/<p>.json --object ./objects/<o>.json
```

## Artefactos
- Descarga + checksums + firma
- SBOM y attestations (si aplica)

## Operación
- Cambios de flags/config: Sí | No
- Rollback mínimo y criterios de abortar

## Créditos Rotativos
- Custodio rotativo: @user
- Contribuciones: @userA
