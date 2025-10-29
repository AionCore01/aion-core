# AION-λ — Release Notes v${MAJOR.MINOR.PATCH}

Fecha: <mention-date start="YYYY-MM-DD"/>
Commit/branch objetivo: <SHA|refs/heads/*>
Ambientes objetivo: staging | prod
Ventana de mantenimiento (si aplica): <YYYY-MM-DDThh:mmZ ... YYYY-MM-DDThh:mmZ>
Custodio rotativo de release: @user
Coordinación: @user

---

## Resumen ejecutivo
- TL;DR de 3–5 líneas con propósito, impacto y foco.
- Issue "Release checklist": #<id>
- Advisory (si aplica): #<id> / AION-λ-SA-${YYYY}-${NN}

## Cambios destacados
- feat(cli): …
- fix(core): …
- perf(merkle): …
- docs(readme): …
- test(crypto): …

## Compatibilidad y migraciones
- Backward compatibility: Sí | No
- Breaking changes: listar breve
- Pasos de migración: concretos si aplica
- Deprecations: APIs/flags a remover

## Seguridad
- Vulnerabilidades resueltas: CVE-YYYY-XXXX | AION-λ-SA-${YYYY}-${NN}
- Severidad y alcance: Crítica | Alta | Media | Baja
- Mitigación aplicada y PR de referencia
- Recomendaciones para operadores

## Integridad criptográfica y verificación
- Versionado de algoritmos (hash/firmas): v1 | v2
- Domain-separator: "AION-λ/v1"

### Checksums
```bash
shasum -a 256 -c checksums.txt
```

### Verificación de proofs
```bash
aion verify \
  --leaf "0x<canonicalHash>" \
  --root "0x<merkleRoot>" \
  --proof ./proofs/<proof>.json \
  --object ./objects/<object>.json
```

## Artefactos
- Descargas: enlaces a binarios/paquetes
- Checksums: checksums.txt
- Firmas: cosign/PGP
- SBOM: sbom.json
- Attestations: SLSA/provenance

## Observabilidad
- KPIs monitoreados post-release
- Alarmas/alerting verificados: Sí | No
- Cambios de logging/redactions

## Notas para operadores
- Flags/ENV relevantes
- Límites, cuotas, timeouts
- Plan de rollback y criterios de abortar

## Créditos Rotativos
- Custodios temporales del release: @user1 @user2
- Contribuciones destacadas: @userA @userB
- Agradecimientos de seguridad

## Indicadores de compromiso (si aplica)
- IoCs y mitigaciones

## Enlaces útiles
- [SECURITY.md](http://SECURITY.md)
- [CONTRIBUTING.md](http://CONTRIBUTING.md)
- Issue "Release checklist"
- Hotfix checklist
- Status page

---

### Firma del release
- Tag firmado: v${MAJOR.MINOR.PATCH}
- PGP/cosign: completar canal oficial
