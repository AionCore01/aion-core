#!/usr/bin/env ts-node
/**
 * gen-keys.ts
 * Genera par Ed25519 (pk_root/dev_sk_root) para Aion Core IDP
 * Salida: JSON canónico para parseo robusto con jq
 */

import sodium from 'libsodium-wrappers';
const bs58 = require('bs58');

(async () => {
  await sodium.ready;
  const kp = sodium.crypto_sign_keypair();
  const pk_b58 = 'base58:' + bs58.encode(Buffer.from(kp.publicKey));
  const sk_b58 = 'base58:' + bs58.encode(Buffer.from(kp.privateKey)); // 64 bytes
  console.log(JSON.stringify({ pk_root: pk_b58, dev_sk_root: sk_b58 }));
})();
