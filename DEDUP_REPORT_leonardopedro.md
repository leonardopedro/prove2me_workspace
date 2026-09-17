# Deduplication report — theorems proved/accepted by `leonardopedro`

*Generated 2026-09-17 against prove2me API `0.10.4`, default environment `Mathlib 0df444a (Lean v4.33.1)` (`0df444a360eaa60ab8c11dca51a86af692955474`). Read-only; no platform state was changed.*

Tooling: `debug/find_duplicates.py` (resumable catalogue index) + `debug/dedup_report.py` (this report). See `PIPELINE_PLAN.md` §1n.

## Headline

* account `leonardopedro` (`2971852e-b5c1-45d5-9a04-1cf04a820ed1`): `num_solved_prob = 616` — 616 entries in the solved list, 616 matched in the catalogue (0 unmatched).
* catalogue indexed: **73968 distinct rows** (66829 theorems + defs excluded).
* **0** solved theorems are *statement-identical* to a **Proved theorem by another user** — these are the proofs that could have been a one-line import.
* **2** more share the token signature of another user's Proved theorem (near; manual triage).
* **2** of our own nodes restate *another of our own* nodes (internal duplication — two catalogued nodes for one claim).
* context: the catalogue holds **6137** statement-duplicate groups, **290** of them spanning more than one author.

### What an exact “0” means, and does not mean

A name-stripped *exact* statement match is a conservative test: it requires the two Lean types to be character-identical after whitespace normalization, so differently-named or API-restated versions of the same fact register as *near*, not as duplicates. A zero in a class is therefore a lower bound on the true overlap, and the near/leaf sections are where the remaining reuse lives.

Most of our proved theorems are **project-specific** `BookProof.*` statements built on our own definitions (`PosSymOp`, `dsComparison`, `lagrangianCore`, …); no other user states them, so no cross-author duplicate should be expected, and finding none is the correct answer, not a gap in the scan.

## A. Internal duplication — two of our nodes for one claim

* `theorem _ (p q : MvPolynomial (Fin d) ℂ) : cpoly (p + q) = cpoly p + cpoly q`
  - `BookProof.HermiteQuadraticEsa.cpoly_add` — Proved, `e81100ec-1be6-45b4-bfcc-4ba4ca80eedc`
  - `BookProof.QgHermiteFriedrichs.cpoly_add` — Proved, `a624b3ee-515c-4a8d-a138-70b628ac87bf`
* `theorem _ (r s : MvPolynomial (Fin d) ℂ) : gaussInt (r - s) = gaussInt r - gaussInt s`
  - `BookProof.QgHermiteFriedrichs.gaussInt_sub` — Proved, `91fe1f87-581a-4019-9430-f07bacf117d7`
  - `BookProof.YangMillsHermite.gaussInt_sub` — Proved, `b9e1ba6f-765c-462f-b5b3-373a30eb7679`

**Action.** Keep one as canonical and make the other a downstream reference (or deprecate the redundant node with `PATCH /theorems/:id`), so future agents import the canonical one.

## B. Solved theorems that exactly restate another user's Proved theorem

_None._  No solved theorem of this account is an exact (name-stripped) restatement of a Proved theorem by another user.

## C. Near duplicates — same token signature as another user's Proved node

Signature matches are token-set based, so a generic statement can match an unrelated one; each row below still needs a human read. (In the run of 2026-09-17, only `conj_mul_self` ≈ `AsaiLargeSieve.sq_ofReal_norm` is a genuine restatement; `half_cast`'s twins are syntactic false positives.)

* ours `BookProof.NavierStokesFlow.DiffHashimoto.half_cast` (`1319c85e-8c73-44ca-bbf4-bc4e086731de`)
  - `theorem _ : (((1 / 2 : ℝ) : ℂ)) = (1 : ℂ) / 2`
  - theirs `mme_entropy_surplus_arith` by **WillR** (`cf6fdb68-c5b0-4c40-9ea0-70f66890ea30`): `theorem _ : ((49 : ℕ) : ℝ) < ((5 : ℕ) : ℝ) * (((25 : ℕ) : ℝ) ^ ((3952233 : ℝ) / 5000000))`
  - theirs `WorkbookSource.plus_18240` by **wamlart** (`72fcbd53-f475-4970-ae5a-1a5e6e1cbff9`): `theorem _ : (6!)^5! ∣ (6!)!`
  - theirs `WorkbookSource.base_56627` by **wamlart** (`f225f584-6308-4a4c-afa4-9dd8ffede92d`): `theorem _ : (2:ℝ) ^ 2002 * 2002! < 2003 ^ 2002`
* ours `BookProof.QgHermiteFriedrichs.conj_mul_self` (`93b94d5a-ab8a-4d59-a914-9a21a1b0423f`)
  - `theorem _ (z : ℂ) : (starRingEnd ℂ) z * z = ((‖z‖ ^ 2 : ℝ) : ℂ)`
  - theirs `AsaiLargeSieve.sq_ofReal_norm` by **raver1975** (`33619629-012b-4e45-8fb8-3e7460940cae`): `theorem _(z : ℂ) : ((‖z‖ : ℂ)) ^ 2 = z * (starRingEnd ℂ) z`
  - theirs `Product_of_Complex_Conjugates` by **Community (Bot)** (`23b39e0b-c400-435a-9af4-8f12b9eed069`): `theorem _ (z₁ z₂ : ℂ) : starRingEnd ℂ (z₁ * z₂) = starRingEnd ℂ z₁ * starRingEnd ℂ z₂`
  - theirs `Sum_of_Complex_Conjugates` by **Community (Bot)** (`393ff6c5-2a04-4c58-9c97-2c11931e1a53`): `theorem _ (z₁ z₂ : ℂ) : starRingEnd ℂ (z₁ + z₂) = starRingEnd ℂ z₁ + starRingEnd ℂ z₂`

## D. Reuse shortlist — another user's Proved node with our leaf name

* `BookProof.ChapterSirkDiffusiveDecay.norm_heatFlow_le` — other authors: `NavierStokes.norm_heatFlow_le`/korbonits
* `BookProof.ChapterH1.phi_zero` — other authors: `PythHydra.phi_zero`/raver1975

## E. Platform-wide duplicate backlog (context)

The scan finds **6137** statement-duplicate groups, **290** across authors. None of our solved theorems is in an exact cross-author group, but the backlog is real and is the pool a future wave should import from rather than re-prove. The reusable *instruments* for the new Faris–Lavine / Fock work (Fourier/Parseval, convolution symmetry, Schur row bounds, coercivity, singular-value norm, `H^s` form domain) are listed with ids in the timepiece `CONSOLIDATED_PLAN.md`, §“Cross-platform reuse”.

## F. The theorems already in the pipeline — does any restate an existing node?

Same matcher, applied to every `Theorems/Thm_*.lean` stub named in `pipeline/wave_upload.json` (`debug/find_duplicates.py --report`). This is the **avoid duplication in prove2me** check for the incoming work: a wave theorem that already exists on the platform should be re-published as a reduction, not re-proved.

* wave theorems parsed: **1289**; already present under their own dotted name: **1270**; live pending frontier: **19**.

| class | collisions | with a `Proved` node |
| :-- | --: | --: |
| `STMT` | 0 | 0 |
| `DECL` | 0 | 0 |
| `SIG` | 0 | 0 |
| `NAME` | 0 | 0 |
| `LEAF` | 67 | 67 |

The only non-trivial classes:


Cross-author `LEAF` hits with a non-generic leaf name: **3** (the rest are false positives on generic leaves such as `add`, `car`, `sum`):

* `BookProof.ChapterSirkDiffusiveDecay.norm_heatFlow_le` ≈ `NavierStokes.norm_heatFlow_le` by **korbonits** (`88931298-072a-4967-8cad-f09e15b5d75d`) — `namespace NavierStokes theorem norm_heatFlow_le {ν : ℝ} (hν : 0 < ν) (t : ℝ) {f : Vec 3 → Vec 3} {M : ℝ} (hM : ∀ y, ‖f y`
* `BookProof.ChapterH1.phi_zero` ≈ `PythHydra.phi_zero` by **raver1975** (`0e291c0d-f2f8-4f88-aa2a-59bc0d935bbe`) — `theorem _(k : ℕ) : phi k 0 = 1`
* `BookProof.HermiteQuadraticEsa.abs_coord_le_norm` ≈ `QFS.abs_coord_le_norm` by **dbenbenn** (`9fed8780-d3ea-4228-820b-252f6afb439a`) — `lemma _ (x : EuclideanSpace ℝ (Fin d)) (i : Fin d) : |x i| ≤ ‖x‖`

**Conclusion.** No wave theorem is an exact restatement of another user's node, so there is no pipeline item to re-publish as a cross-author reduction. The reusable material for the *new* Faris–Lavine / Fock work is the instrument table of `CONSOLIDATED_PLAN.md` §“Cross-platform reuse”, not a wave-node twin.

### F.1 The additions that are *not* in the wave (the Fourier-elimination wave, 2026-09-17)

Same matcher, but reading the declarations from the source instead of from stubs, because a new
addition has no `Theorems/Thm_*.lean` yet (`debug/find_duplicates.py --module`):

```
python3 debug/find_duplicates.py --module ../timepiece/BookProof/ChapterNsFourierElimination.lean \
    --namespace BookProof.NsFullEuler
python3 debug/find_duplicates.py --module ../timepiece/BookProof/ChapterProve2meReuse.lean \
    --namespace BookProof.Prove2meReuse
```

The complete set of Lean modules added to timepiece since the previous wave (`git status`-derived),
re-run 2026‑09‑17:

| module | declarations | `STMT` | `DECL` | `SIG` | `NAME` | `LEAF` |
| :-- | --: | --: | --: | --: | --: | --: |
| `ChapterNsFourierElimination.lean` (3 `abbrev` compared by name only) | 82 | 0 | 0 | 0 | 0 | 0 |
| `ChapterProve2meReuse.lean` (7 of them named hypotheses) | 14 | 0 | 0 | 0 | 0 | 0 |
| `Book/FourierElimination.lean` (Verso manual chapter: `#check`s only, no declarations) | 0 | 0 | 0 | 0 | 0 | 0 |
| `ChapterNsLagrangianFourierElimination.lean` (WIP scaffold — *provisional*) | 36 | *0* | *0* | *0* | *0* | *0* |

The first module was 65 declarations when this section was written and is 82 now (the advection
section was added afterwards), which is why the pass was re-run rather than trusted.

Nothing to re-publish as a reduction, and nothing for the new modules to import: they are built
from timepiece's own instruments (`weylOp*`, `friedrichs_extension_exists`,
`dsComparison`/`dsOp*`, `Comparison.esa_self`, `momOp_polySym`/`mulOp_polySym`/`RealCoeff`) plus
Mathlib's `MvPolynomial` API. The seven cross-author, Mathlib-only theorems that *are* reusable for
the route remain the named hypotheses of `ChapterProve2meReuse.lean`, frozen in
`../timepiece/PROVE2ME_REUSABLE_THEOREMS.md`. Run `--module` before growing the wave for any new
module; a `STMT` hit is an import reduction, never a fresh proof.

**One addition is pending, not classified.** The Lagrangian half of the same plan item
(`../timepiece/BookProof/ChapterNsLagrangianFourierElimination.lean`) is a handoff scaffold that
does not yet elaborate (two `Fin 36`-index lemmas exceed the heartbeat budget, and §4–5 sit on top
of them), so it is recorded here as **pending** rather than as 0/0/0/0 on half-written proofs.  It
is unimported and in no Lake target; re-run the `--module` pass on it once it compiles.  What that
module *does* already establish, and what is machine-checked outside Lean, is a **negative** result
for the plan: the mode-wise elimination in material variables is degenerate — `F = ℓ ⊗ ξ` is rank
one, so the eliminated cofactor vanishes (the entire Piola pressure coupling dies) and
`det F = 0`, collapsing the volume constraint to the constant `−1`.  Cadabra checks `B4a–B4d`,
`B5`, `B5b` of `../timepiece/DESIGN_COMPARISON_N_20260915.cdb` verify exactly that, and they are
what shows the older degree checks `B1–B3` were trivially satisfied and therefore misleading.
Nothing about this changes the platform-side picture: still no re-publish, still no import.

## Method and caveats

* Ground truth for “proved by us” is `GET /users/<uid>` → `solved_problems` (PIPELINE_PLAN.md §1g/§1h). `created_by` alone over-counts (a node we published Open can be Proved later by anyone), and `GET /submissions` is a truncated window.
* Statements are compared **name-stripped**: the platform stores `theorem <full.name> <binders> : <type> := by sorry`, so the module name is removed before hashing; otherwise every equality would be a name equality. Definitions (empty statements) are excluded.
* Catalogue was indexed once in the default environment; paging returned 73968 distinct rows of a reported total, so a small overlap across pages is possible and coverage is close to complete but not provably exhaustive.
* The matcher is **syntactic**: it does not know that two statements are logically equivalent under different casts/coercions, nor that one implies the other. Treat “near” as a triage list, not a verdict.
* Re-run after each upload wave: `python3 debug/find_duplicates.py --reset --index` (in bounded chunks) then `python3 debug/dedup_report.py`.
