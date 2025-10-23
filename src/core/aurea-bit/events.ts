// events.ts — utilidades deterministas v0.1
import crypto from 'crypto';

/**
 * stableStringify - Serializa un objeto a JSON canónico ordenado
 * Las claves se ordenan alfabéticamente para garantizar determinismo
 */
export function stableStringify(obj: unknown): string {
  if (obj === null || typeof obj !== 'object') return JSON.stringify(obj);
  if (Array.isArray(obj)) return '[' + obj.map(stableStringify).join(',') + ']';
  const rec = obj as Record<string, unknown>;
  const keys = Object.keys(rec).sort();
  return '{' + keys.map(k => JSON.stringify(k) + ':' + stableStringify(rec[k])).join(',') + '}';
}

/**
 * sha256Hex - Genera hash SHA-256 en formato hexadecimal
 */
export function sha256Hex(input: string): string {
  return crypto.createHash('sha256').update(input).digest('hex');
}

/**
 * makeMerkleLeaf — hoja canónica sin raíz (rootless)
 * 
 * Inputs canónicos:
 * - actor_id: DID o identificador estable
 * - outputs: { bit?: number; aurea?: number; fee?: number }
 * - inputsHash: h0 del experimento (0x...)
 * - policy_version: "v0.1" (o la actual)
 * 
 * Retorna "0x" + sha256(canonical_json)
 */
export function makeMerkleLeaf(params: {
  actor_id: string;
  outputs: { bit?: number; aurea?: number; fee?: number };
  inputsHash: string;
  policy_version: string;
}): string {
  const canonical = stableStringify({
    actor_id: params.actor_id,
    inputsHash: params.inputsHash,
    outputs: params.outputs,
    policy_version: params.policy_version
  });
  return '0x' + sha256Hex(canonical);
}

/**
 * Stub para merkle_root - implementación futura
 * Por ahora retorna un placeholder
 */
export function makeMerkleRoot(leaves: string[]): string {
  // TODO: Implementar árbol de Merkle completo
  if (leaves.length === 0) return '0x' + '0'.repeat(64);
  if (leaves.length === 1) return leaves[0];
  // Placeholder: hash de la concatenación de todas las hojas
  return '0x' + sha256Hex(leaves.join(''));
}
