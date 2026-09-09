# prove2me-lean4.33-translation (vendored reference)

Vendored copy of `/home/leo/Projects/prove2me-lean4.33-translation/` — the
v4.28 → v4.33.1 translation handoff (authoritative drift-class catalogue, repair
templates, generator scripts, and fixed/failing artifacts).

## Contents

| Path | What it is |
| :--- | :--- |
| `PLAN_LEAN4_33_TRANSLATION.md` | The translation plan: drift classes (§2), working order (§4), file map of fixed/failing artifacts. **Read before touching any Lean file.** |
| `scripts/` | The wave generator (`wave_generate.py`), spec assembler (`wave_upload_spec.py`), metadata helpers. Kept in sync with `scripts/` at the workspace root (the root copies are the live ones). |
| `source_chapters/` | v4.33-fixed source chapters (MajoranaClifford, MajoranaProp76, YangMillsBianchi, YangMillsSU3). |
| `fixed_solutions/` | Solutions fixed during the v4.33 translation (already applied in `Solutions/`). |
| `failing_solutions/` | Known-still-failing solutions (kept for diagnosis). |
| `thm_fixes/` | Theorem-stub fixes already applied (e.g. MajoranaProp76 LinearIsometryEquiv). |
| `notes/` | Axiom-gate batch runs and notes. |

## Sync policy

- The **live** generator is `scripts/wave_generate.py` at the workspace root.
  When it changes, copy it here (`cp scripts/wave_generate.py
  references/prove2me-lean4.33-translation/scripts/`).
- The external folder `/home/leo/Projects/prove2me-lean4.33-translation/` is a
  non-git handoff; this vendored copy makes it part of the repo so it cannot be
  lost. If the external folder gains new content, copy it here and commit.