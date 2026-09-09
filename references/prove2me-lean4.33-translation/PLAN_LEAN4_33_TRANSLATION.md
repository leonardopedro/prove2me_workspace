# Plan: Porting timepiece Lean 4 code from v4.28.0 → v4.33.1 (Prove2me)

**Audience:** an LLM Lean-4 specialist working on the Prove2me transplant.
**Context:** the timepiece project pins `leanprover/lean4:v4.28.0`; Prove2me's
default platform environment is `leanprover/lean4:v4.33.1` / Mathlib commit
`0df444a360eaa60ab8c11dca51a86af692955474`. All theorem *statements* on the
platform elaborate against v4.33.1, so any source code that compiled on v4.28
must be re-validated (and, where Mathlib APIs drifted, repaired) against v4.33.1
before upload. This document is the roadmap for that repair.

---

## 0. Where things live

| Path | What it is |
| :--- | :--- |
| `/home/leo/Projects/timepiece` | Source Lean 4 project, pinned to **v4.28.0**, `.lake` build present. This is the authoritative source. |
| `/home/leo/prove2me_workspace` | The Prove2me working workspace, pinned to **v4.33.1 / Mathlib 0df444a** with prebuilt oleans. Generated mirror lives in `Definitions/`, `Theorems/`, `Solutions/`. |
| `/home/leo/Projects/prove2me-lean4.33-translation/` | **This handoff folder** — fixed/failing artifacts, scripts, and notes for the translation work. |
| `pipeline/wave_upload.json` | The wave spec consumed by `pipeline/upload_pipeline.py`. |

Local compile gate (run in the workspace): `lake env lean <file.lean>` — exit 0 = clean.

---

## 1. Goal and scope

Publish timepiece theorems to Prove2me. The current wave is the **QYM/SIRK/Majorana
wave**: 8 self-contained (Mathlib-only) chapters — `ChapterBaryonAsymmetry`,
`ChapterMajoranaClifford`, `ChapterMajoranaProp61`, `ChapterMajoranaProp76`,
`ChapterParityMajoranaQuant`, `ChapterYangMillsBianchi`, `ChapterYangMillsSU3`,
`ChapterSirkGroupTransfer` — generating 8 definition bundles + 59 theorem stubs +
59 solution files.

**Constraint:** solutions must be axiom-clean (`#print axioms` ⊆
`{propext, Classical.choice, Quot.sound}`) and `sorry`-free; theorem statements
must elaborate against v4.33.1.

**Out of scope:** the `ChapterNavierStokesSignedShift` wave (needs a 14-module
NS def-cone publication; the generator only handles Mathlib-only chapters). See
§7.

---

## 2. The drift classes encountered so far (v4.28 → v4.33.1)

Each class is a **pattern** — a failure mode + a repair template. The repaired
files are in `fixed_solutions/` and `thm_fixes/` as worked examples.

### 2.1 `grind` regression (tactic no longer closes goals it used to)

- **Failure:** `grind +suggestions` (and `grind +locals`) leaves unsolved goals
  that v4.28 closed.
- **Affected:** `ChapterYangMillsBianchi` `bianchi` (Jacobi identity over an
  arbitrary `Ring R`).
- **Repair:** expand the bracket and use `noncomm_ring`:
  ```lean
  import Mathlib.Tactic.NoncommRing
  ...
  simp [Fin.sum_univ_three, eps]
  simp [Int.sign]
  simp only [Bracket.bracket]
  noncomm_ring
  ```
  ⚠️ `ring` is NOT a substitute: in this Mathlib, `ring`/`ring_nf` require a
  **commutative** ring and report `ring_nf made no progress` on a bare `Ring R`.
  For genuinely non-commutative ring identities use `noncomm_ring` (from
  `Mathlib.Tactic.NoncommRing`).

### 2.2 Removed `Ring → LieRing` instance

- **Failure:** `lie_jacobi` / `lie_skew` "failed to synthesize `LieRing R`" for
  `[Ring R]`. v4.28 auto-synthesized it; v4.33 only provides
  `LieRing.ofAssociativeRing` as a **local** instance inside
  `Mathlib/Algebra/Jordan/Basic.lean`.
- **Affected:** `ChapterYangMillsBianchi` `bianchi_cyclic`,
  `fieldStrength_antisymm` (and anything using `lie_jacobi`/`lie_skew` on a ring).
- **Repair:**
  ```lean
  import Mathlib.Algebra.Jordan.Basic
  ...
  attribute [local instance 100] LieRing.ofAssociativeRing
  ```

### 2.3 `simp` stopped unfolding a `@[simp]` lemma

- **Failure:** `simp` left `Qform v` unreduced in
  `ChapterMajoranaClifford.a_sq`, so the goal
  `algebraMap (Qform v) = algebraMap ‖v‖²` stayed open.
- **Repair:** add the missing rewrite explicitly before `simp`:
  ```lean
  rw [a, ι_sq_scalar]
  rw [Qform_apply]        -- the @[simp] lemma is not firing on its own
  ```
  (If the goal closes at `rw`, do NOT keep a trailing `simp` — it errors
  "No goals to be solved".)

### 2.4 Ambiguous `smul_apply` / `sum_apply` (Matrix vs `_root_`)

- **Failure:** `simp only [smul_apply, sum_apply, ...]` → "Ambiguous term";
  v4.33 added `Matrix.smul_apply` / `Matrix.sum_apply` shadowing the root ones.
- **Affected:** `ChapterYangMillsSU3.structureConstant_jacobi`.
- **Repair:** qualify with `_root_.`:
  ```lean
  simp only [_root_.sum_apply, _root_.smul_apply, ...]
  ```

### 2.5 Generator bug: bogus `open <Ns>` for dot-named theorems

- **Failure:** `open BookProof.ChapterMajoranaProp76.LinearIsometryEquiv` →
  "unknown namespace". The generator's `opens_for` treats every dot-named
  theorem's parent (`X.Y` from `theorem Y.thing`) as a namespace, but for
  `theorem LinearIsometryEquiv.isNote4Unitary` the "parent" is a **type name**
  in scope, not a namespace.
- **Affected:** `ChapterMajoranaProp76` `LinearIsometryEquiv.isNote4Unitary`
  (Thm + Sol).
- **Repair:** delete the bogus `open ...LinearIsometryEquiv` line; the
  fully-dotted statement + `open BookProof.ChapterMajoranaProp76` is sufficient.
  **Generator fix needed** (see §6): `opens_for` must only emit `parent` when it
  is a *real* namespace (check for a `namespace` declaration / non-theorem scope),
  or when the parent is a structure the statement genuinely references.

### 2.6 `exact ⟨Finset.sum_congr rfl ..., ...⟩` on an entry-level goal (STILL OPEN)

- **Failure (current):** `ChapterYangMillsSU3.structureConstant_jacobi`, line 53:
  ```
  exact ⟨ Finset.sum_congr rfl fun _ _ => by ring, Finset.sum_congr rfl fun _ _ => by ring ⟩;
  ```
  The goal at that point is a **conjunction of two entry-level ℝ equalities**
  (`.re` and `.im` of matrix entries), not two matrix-level sum equalities:
  ```
  ((-∑ g, (↑(f a b e) * ↑(f e c g)) • T g) i j).re =
    ((∑ x, Complex.I • f a b e • Complex.I • f e c x • T x) i j).re ∧ ... im ... im
  ```
  In v4.28 the preceding `simp only [...]` (with `Complex.ext_iff`) left a
  matrix-level pair of sums, so `Finset.sum_congr` applied; in v4.33 the
  `.re`/`.im` split reaches entry level and the `by ring` goals are open
  (`ring_nf made no progress`).
- **Suggested repair** (not yet verified — this is your task):
  - Reduce `Complex.I • f a b e • Complex.I • f e c x` to `- (f a b e * f e c x)`
    *before* the split: add simp lemmas like `Complex.mul_I_im`, `Complex.I_mul_re`,
    `Complex.I_mul_im`, `Complex.mul_I_re` and/or `smul`-of-`I` lemmas to the
    `simp only` at line 47-52, so each side is a plain real sum of `f`-products;
  - then close the two ℝ goals with `ring` (commutative `ℝ` — `ring` works here);
  - or replace the `exact ⟨...⟩` with:
    ```lean
    · -- re part
      rw [← Finset.sum_neg_distrib, Finset.sum_apply] -- then simp the I•I, ring
    · -- im part (same)
    ```
  - Watch for the "unused simp argument" linter warnings (lines 47, 48): the
    `neg_apply` / `_root_.smul_apply` in the *first* `simp only` are now unused;
    trim them to keep the file lint-clean.
- **Worked example of the surrounding structure:** see
  `fixed_solutions/Sol_BookProof_YangMillsBianchi_bianchi.lean` (the `simp only
  [Bracket.bracket]; noncomm_ring` pattern) and `failing_solutions/...jacobi.lean`.

---

## 3. Files: what each fixed artifact demonstrates

| File | Drift class |
| :--- | :--- |
| `fixed_solutions/Sol_BookProof_MajoranaClifford_a_sq.lean` | §2.3 (`rw [Qform_apply]`) |
| `fixed_solutions/Sol_BookProof_YangMillsBianchi_bianchi.lean` | §2.1 (`grind` → `noncomm_ring`) |
| `fixed_solutions/Sol_BookProof_YangMillsBianchi_bianchi_cyclic.lean` | §2.2 (`LieRing.ofAssociativeRing`) |
| `fixed_solutions/Sol_BookProof_YangMillsBianchi_fieldStrength_antisymm.lean` | §2.2 (same) |
| `fixed_solutions/Sol_BookProof_YangMillsBianchi_bianchi_fieldStrength.lean` | verifies it builds after `bianchi` fixed |
| `thm_fixes/Thm_..._LinearIsometryEquiv_isNote4Unitary.lean` | §2.5 (bogus `open` removed) |
| `thm_fixes/Sol_..._LinearIsometryEquiv_isNote4Unitary.lean` | §2.5 (bogus `open` removed) |
| `failing_solutions/Sol_BookProof_YangMillsSU3_structureConstant_jacobi.lean` | §2.4 (fixed) + §2.6 (OPEN) |

All other generated Thm/Sol files in the wave build clean under v4.33.1.

---

## 4. Recommended working order (for the specialist)

1. **Verify the gate is green.** In `/home/leo/prove2me_workspace`:
   ```bash
   export PATH="/home/leo/.elan/bin:$PATH"
   lake build          # expect only the one SU3 jacobi failure
   ```
2. **Fix §2.6** (`structureConstant_jacobi`), using the diagnostic in §2.6 and
   `failing_solutions/` as the starting file. Re-run `lake env lean` on the file
   until exit 0. Keep it lint-clean (≤100 chars/line, no trailing whitespace, no
   unused simp-arg warnings if feasible).
3. **Re-run the full build**; every Thm + Sol + Def must compile. Confirm all 59
   Thm files are `sorry`-stubs that build, all 59 Sol files are sorry-free.
4. **Axiom gate (Phase 0) already passed** for this wave (0 BAD); re-run only if
   you touch statements:
   ```bash
   cd /home/leo/Projects/timepiece && lake env lean /tmp/.../axiom_gate_batch2.lean
   ```
   (the gate file lives in `/tmp/opencode/axiom_gate_batch2.lean`; move it into
   the Projects folder before relying on it — see §5.)
5. **Regenerate metadata/spec** only if you change names/sources:
   ```bash
   cd /home/leo/prove2me_workspace
   python3 scripts/wave_docstrings.py && python3 scripts/wave_metadata.py
   python3 scripts/wave_upload_spec.py   # -> pipeline/wave_upload.json
   ```
6. **Upload** via the pipeline (see PIPELINE_PLAN.md §5-7): the `upload_pipeline.py`
   reads `pipeline/wave_upload.json`; start the service
   (`sudo systemctl start upload-timepiece`) or run the script manually as leo.
7. **Post-upload hygiene:** keep `state/pipeline.json` (append-only); update
   PIPELINE_PLAN.md's status snapshot.

---

## 5. Artifacts still in /tmp that should be copied into Projects

The following were created during this session and are **not yet** in the
handoff folder (per the instruction to keep useful files out of /tmp):

| /tmp path | Purpose | Action |
| :--- | :--- | :--- |
| `/tmp/opencode/axiom_gate_batch2.lean` | Phase-0 axiom gate for the 8-chapter wave | copy to `notes/axiom_gate_batch2.lean` |
| `/tmp/opencode/test_bianchi*.lean`, `test_jacobi_su3*.lean`, `test_cyclic*.lean`, `test_sq.lean`, `test_ring*.lean`, `test_jacobi.lean`, `test_jacobi2.lean` | exploration scratch proving the §2 repairs | copy the ones that succeeded (final versions) into `notes/scratch_fixes/` |
| `/tmp/opencode/lake_build.log` | lake output log | optional |

I will copy these as part of finalizing this handoff.

---

## 6. Generator fixes (needed before the NEXT wave)

The drift exposed two generator bugs in `scripts/wave_generate.py`:

1. **`opens_for` (line ~267) emits bogus `open` for dot-named theorems** (§2.5).
   Fix: only emit `parent` when it corresponds to a real namespace — i.e. when
   the parent scope of the theorem is a declared `namespace` (not a dot-name
   within a theorem's own name, like `LinearIsometryEquiv.isNote4Unitary` where
   `LinearIsometryEquiv` is a type). A robust heuristic: re-elaborate the
   generated Thm; if `open <parent>` fails, drop it.
2. **No import of `Mathlib.Tactic.NoncommRing` / `Mathlib.Algebra.Jordan.Basic`
   when the proof needs them.** The generator emits `import Mathlib` +
   `import Definitions.Def_<leaf>`. The §2.1/§2.2 repairs require extra imports.
   Rather than hard-code, keep the wave's generated files and patch by hand (as
   done here), or teach the generator to include the two extra imports when the
   source chapter references `ring_commutator`/`lie_jacobi`.

These are lower priority than completing the current wave; do them before the
next wave's generation.

---

## 7. The NS SignedShift wave (deferred)

`ChapterNavierStokesSignedShift` (29 nodes, manifest already generated) is
**blocked**: its definition bundle imports `BookProof.ChapterNavierStokesAffineFiberEsa`,
which requires publishing a ~14-module NS def-cone (`ShiftHamiltonian`,
`IkebeKato`, `HermiteFarisLavine`, `AffineFiberEsa`, `FarisLavine`,
`FarisLavineCore`, `NavierStokesDeficiency`, `NavierStokesEsa`,
`NavierStokesFlow`, `NavierStokesCauchy`, `GhostField`, `FreeFieldConstraint`,
`ContinuityUnitary`, `ContinuityUnitaryInfinite`, `U`, ...) as platform
Definition bundles with rewritten imports — machinery the current generator does
not have (it is Mathlib-only). This is a separate, larger effort; do not mix it
into the current wave. The leftover generated `SignedShift`/`QgBrstDerivativeGauge`
files were removed from the mirror; keep them out unless the cone work lands.

---

## 8. Quick reference (tactic/lemma facts verified on v4.33.1)

- `ring` / `ring_nf` → commutative rings only; `noncomm_ring` → non-commutative
  (`import Mathlib.Tactic.NoncommRing`).
- `lie_jacobi`, `lie_skew` need `[LieRing R]`; for a `Ring` add
  `attribute [local instance 100] LieRing.ofAssociativeRing` after
  `import Mathlib.Algebra.Jordan.Basic`.
- `⁅a, b⁆` on a ring = `Bracket.bracket` = `Ring.instBracket`; unfold with
  `simp only [Bracket.bracket]`.
- `smul_apply` / `sum_apply` ambiguous with Matrix: use `_root_.smul_apply` /
  `_root_.sum_apply`.
- `Complex.ext_iff` splits a ℂ equality into `.re ∧ .im`; apply `ring` on the ℝ
  halves (commutative).
- A `@[simp]` lemma that stops firing (e.g. `Qform_apply`): add an explicit
  `rw [Qform_apply]` before `simp`; drop a trailing `simp` once the goal is
  closed.
- `lake env lean <file>` is the single-file compile gate; `lake build` validates
  the whole mirror.