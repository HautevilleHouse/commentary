const n = 4, points = 1 << n, functions = 1 << points;
function mexSet(xs) { const s = new Set(xs); let k = 0; while (s.has(k)) k++; return k; }
function blockSensitivity(table, x) {
  const valid = [];
  for (let b = 1; b < points; b++) if (((table >> x) & 1) !== ((table >> (x ^ b)) & 1)) valid.push(b);
  function search(i, used) {
    let best = 0;
    for (let j = i; j < valid.length; j++) {
      const b = valid[j];
      if ((used & b) === 0) best = Math.max(best, 1 + search(j + 1, used | b));
    }
    return best;
  }
  return search(0, 0);
}
const dist = new Map(); let maxS = 0, maxB = 0;
for (let table = 0; table < functions; table++) {
  let s = 0, b = 0;
  for (let x = 0; x < points; x++) {
    let sx = 0;
    for (let bit = 0; bit < n; bit++) if (((table >> x) & 1) !== ((table >> (x ^ (1 << bit))) & 1)) sx++;
    s = Math.max(s, sx); b = Math.max(b, blockSensitivity(table, x));
  }
  if (b > s * s) throw new Error(`inequality failure at ${table}`);
  maxS = Math.max(maxS, s); maxB = Math.max(maxB, b);
  const key = `${s},${b}`; dist.set(key, (dist.get(key) || 0) + 1);
}
console.log(`functions=${functions} inequality=PASS`);
console.log(`max_sensitivity=${maxS} max_block_sensitivity=${maxB}`);
console.log(`distribution=${JSON.stringify([...dist.entries()].sort())}`);
