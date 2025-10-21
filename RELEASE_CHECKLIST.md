# Checklist de Release — aion-core

## Identidad y determinismo
- [ ] Bump de versión semántica aplicado
- [ ] `inputsHash` de artefactos canónicos calculado y documentado
- [ ] Reproducibilidad verificada: mismo input → mismo output
- [ ] `events_schema.json` estable o con migration plan

## Pruebas y calidad
- [ ] CI en verde (tests + lint + build reproducible)
- [ ] Code scanning/Dependabot sin issues críticas
- [ ] Cobertura mínima aceptable (si aplica)

## Seguridad
- [ ] Revisión de dependencias nuevas
- [ ] Sin secretos en cambios
- [ ] Permisos mínimos en workflows

## Documentación
- [ ] CHANGELOG.md con breaking changes y hash de artefactos
- [ ] Reference a commits/tags firmados
- [ ] Guía de migración si cambia spec/ o schema

## Gobernanza y guardianía
- [ ] Aprobaciones requeridas (CODEOWNERS, 2 reviewers)
- [ ] Evidencia de revisión de guardian/es
- [ ] Pausa segura probada si corresponde (publisher/pauser)

## Publicación
- [ ] Tag firmado creado (git tag -s vX.Y.Z)
- [ ] Release notes con checksums (SHA256) y `inputsHash`
- [ ] (Opcional) Anclaje on-chain de hash en milestone

## Post-release
- [ ] Crear issue de seguimiento para validadores externos
- [ ] Monitoreo de regresiones en observer/dashboard
