# Notes

- `axiom_gate_batch2.lean` — the Phase-0 soundness gate for the current
  8-chapter wave (extends `axiom_gate.lean` with the new imports). Run it in
  `/home/leo/Projects/timepiece` (v4.28 project env):
  `lake env lean axiom_gate_batch2.lean`; `grep '^BAD'` must be empty.
  Result of the last run: GATE checked 311 theorems, 0 BAD.
