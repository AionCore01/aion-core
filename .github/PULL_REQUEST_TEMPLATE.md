# Título del PR
Resumen breve y específico

## Objetivo
- ¿Qué problema resuelve?
- ¿Qué artefactos canónicos toca? (spec/, src/core/, infra/)

## Cambios
- [ ] Código
- [ ] Spec / documentación
- [ ] Infra (CI/CD, workflows)
- [ ] Seguridad / permisos

## Checklist de determinismo
- [ ] Mismo input → mismo output comprobado con tests
- [ ] No introduce fuentes de aleatoriedad sin seed explícita
- [ ] No rompe compatibilidad del `events_schema.json` (o documenta breaking change)

## Seguridad
- [ ] Sin secretos en el repo
- [ ] Dependencias nuevas revisadas (SCA)
- [ ] Permisos mínimos en CI

## Pruebas
- [ ] Tests pasan en local
- [ ] CI en verde
- [ ] Casos límite cubiertos

## Relacionado
Closes #ID  |  Relacionado con #ID

## Screenshots / Evidencia (opcional)

## Notas de despliegue
- Migraciones o pasos manuales
- Flags, variables o claves a rotar
