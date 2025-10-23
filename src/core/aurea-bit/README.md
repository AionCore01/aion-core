# Aurea+Bit - Implementación del Motor

> 🚧 **Trabajo en progreso** - Implementación de la especificación v0.1

## Descripción

Este módulo contiene la implementación ejecutable de la máquina de estado Aurea+Bit especificada en `spec/aurea-bit/`.

## Estructura

```
src/core/aurea-bit/
├── README.md          # Este archivo
├── index.ts           # Punto de entrada principal (TODO)
├── glifos.ts          # Funciones puras de transformación (Gv, Gc, Gr, Gd, Gp) (TODO)
├── brazos.ts          # Lógica de los 7 brazos de la máquina (TODO)
├── events.ts          # Tipos y validación de eventos (TODO)
└── tests/
    └── canonical.spec.ts  # Pruebas canónicas v0.1 ✅
```

## Especificación

La especificación canónica se encuentra en:
- **Diagrama**: [`spec/aurea-bit/README.md`](../../../spec/aurea-bit/README.md)
- **Esquema de eventos**: [`spec/aurea-bit/events_schema.json`](../../../spec/aurea-bit/events_schema.json)

## Pruebas Canónicas

Las pruebas canónicas verifican el comportamiento determinista:

### Test 1: core-dev → MintBit
```typescript
contribution = { type: 'core-dev', weight_base: 10 }
resultado = { MintBit: 10, MintAUREA: 0 }
```

### Test 2: comunitaria → MintAUREA
```typescript
contribution = { type: 'comunitaria', weight_base: 1 }
resultado = { MintBit: 0, MintAUREA: 1 }
```

## Ejecutar Tests

```bash
# Ejecutar todas las pruebas
npm test src/core/aurea-bit/tests/

# Ejecutar solo pruebas canónicas
npm test src/core/aurea-bit/tests/canonical.spec.ts
```

## Principios de Implementación
### Determinismo
- Mismo `inputsHash` + `policy_version` → mismos outputs
- Funciones puras sin efectos secundarios
- Snapshots inmutables por tick

### Conservación
```
supply_change = MintBit + MintAUREA - FeesTreasury ≥ 0
```

### Anticolisiones
- Brazos 5 (MintBit) y 6 (MintAUREA) nunca comparten buffer
- Backpressure explícito en todos los buffers

## Glifos (Funciones Puras)

- **Gv**: Validación (schema, signature, window, unique)
- **Gc**: Clasificación (core-dev, comunitaria, research, docs, cuidado, otro)
- **Gr**: Transmutación Risk (weight × k_core × boost_r)
- **Gd**: Transmutación Dignity (weight × k_comm × boost_d)
- **Gp**: Publicación (merkle_leaf, merkle_proof, settlement)

## Brazos

1. **Brazo 1**: Validación de contribuciones
2. **Brazo 2**: Clasificación por tipo
3. **Brazo 3**: Transmutación Risk → RiskPoints
4. **Brazo 4**: Transmutación Dignity → DignityPoints
5. **Brazo 5**: Emisión MintBit → Pool Bit
6. **Brazo 6**: Emisión MintAUREA → Pool AUREA
7. **Brazo 7**: Publicación Settlement

## Policy v0.1

```typescript
const POLICY_V01 = {
  version: 'v0.1',
  k_core: 1.0,
  k_comm: 1.0,
  boosts: 1.0,
  fee_simbiosis: 0,
  rate_limits: {
    BIT: 100,  // por actor/día
    AUREA: 20   // por actor/día
  }
};
```

## Siguiente Paso

Implementar el motor con replay determinista y generador de merkle_leaf.

---

**Versión**: v0.1  
**Estado**: 🚧 Especificación completa, implementación pendiente  
**Especificación**: `spec/aurea-bit/`
