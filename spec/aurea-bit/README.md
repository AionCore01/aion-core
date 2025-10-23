# Aurea+Bit — Especificación v0.1

**Máquina de estado determinista para emitir tokens Bit y AUREA a partir de contribuciones validadas.**

## Diagrama de máquina (ASCII)

```
Reactivos                                     Pools / Publicación
┌───────────────────────┐                     ┌───────────────────────────┐
│ contribution_event    │                     │        Pool Bit           │
│ actor_id, r_t         │                     │        Pool AUREA         │
│ contexto              │                     └────────────┬──────────────┘
└──────────┬────────────┘                                  │
           │                                               │
        [Brazo 1]                                          │
           │                                               │
           ▼                                               │
      ┌─────────┐    (Gv) Validación pura                  │
      │Validated├──────────────────────────────────────────┤
      └─┬───────┘                                          
        │
        │    [Brazo 2]
        ▼
   ┌──────────────┐   (Gc) Clasificación pura
   │ Classified   │───┬─────────────────────────────┐
   └──────┬───────┘   │                             │
          │           │                             │
          │           │                             │
   [Brazo 3]          │                      [Brazo 4]
          │           │                             │
          ▼           │                             ▼
 ┌────────────────┐   │                    ┌─────────────────┐
 │ RiskPoints     │<──┘ (Gr)               │ DignityPoints   │<── (Gd)
 └───────┬────────┘                        └────────┬────────┘
         │                                          │
         │                                          │
     [Brazo 5]                                   [Brazo 6]
         │                                          │
         ▼                                          ▼
 ┌──────────────┐                            ┌───────────────┐
 │ MintBit      │ ────────────────► Pool Bit │ MintAUREA     │ ─────────► Pool AUREA
 └──────┬───────┘                            └───────┬───────┘
        │                                           │
        └──────────────┬────────────────────────────┘
                       │
                       ▼
                   [Brazo 7]
                       │
                       ▼             (Gp) Publicación pura
              ┌─────────────────────────────────────────┐
              │ Settlement: merkle_leaf, merkle_proof   │
              │ machine_run_id, policy_version, hashes  │
              └─────────────────────────────────────────┘
```

## Reloj y barreras

Validación || Clasificación → Transmutación → Emisión → Publicación.

## Backpressure explícito

Buffers: `B_validated`, `B_classified`, `B_risk_points`, `B_dignity_points`, `B_mint_queue`.

## Anticolisiones

Brazos 5 y 6 nunca comparten buffer; snapshots inmutables por tick.

## Policy v0.1 aplicada

- `k_core = 1.0`
- `k_comm = 1.0`
- `boosts = 1.0`
- `fee_simbiosis = 0`
- Rate limits: **100 Bit** y **20 AUREA** por actor/día

## Artefactos canónicos

- `events_schema.json` — Definición de eventos v0.1
- `machine_ascii.md` — Este documento

## Pruebas canónicas

### Test 1: core-dev → MintBit

```json
{
  "type": "core-dev",
  "weight_base": 10,
  "expected": { "MintBit": 10, "MintAUREA": 0 }
}
```

### Test 2: comunitaria → MintAUREA

```json
{
  "type": "comunitaria",
  "weight_base": 1,
  "expected": { "MintBit": 0, "MintAUREA": 1 }
}
```

---

**Versión:** v0.1  
**Fecha:** 2025-10-23  
**Determinismo:** mismo `inputsHash` + `policy_version` → mismos outputs  
**Conservación:** `supply_change = MintBit + MintAUREA - FeesTreasury ≥ 0`
