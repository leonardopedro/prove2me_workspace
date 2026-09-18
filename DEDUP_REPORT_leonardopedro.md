# Deduplication report — theorems proved/accepted by `leonardopedro`

*Generated 2026-09-18 against prove2me API `0.10.5`, default environment `Mathlib 0df444a (Lean v4.33.1)` (`0df444a360eaa60ab8c11dca51a86af692955474`). Read-only; no platform state was changed.*

Tooling: `debug/find_duplicates.py` (resumable catalogue index) + `debug/dedup_report.py` (this report). See `PIPELINE_PLAN.md` §1n.

## Headline

* account `leonardopedro` (`2971852e-b5c1-45d5-9a04-1cf04a820ed1`): `num_solved_prob = 714` — 714 entries in the solved list, 616 matched in the catalogue (98 unmatched).
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

Signature matches are token-set based, so a generic statement can match an unrelated one; each row below still needs a human read. (In the run of 2026-09-18, only `conj_mul_self` ≈ `AsaiLargeSieve.sq_ofReal_norm` is a genuine restatement; `half_cast`'s twins are syntactic false positives.)

* ours `BookProof.QgHermiteFriedrichs.conj_mul_self` (`93b94d5a-ab8a-4d59-a914-9a21a1b0423f`)
  - `theorem _ (z : ℂ) : (starRingEnd ℂ) z * z = ((‖z‖ ^ 2 : ℝ) : ℂ)`
  - theirs `AsaiLargeSieve.sq_ofReal_norm` by **raver1975** (`33619629-012b-4e45-8fb8-3e7460940cae`): `theorem _(z : ℂ) : ((‖z‖ : ℂ)) ^ 2 = z * (starRingEnd ℂ) z`
  - theirs `Product_of_Complex_Conjugates` by **Community (Bot)** (`23b39e0b-c400-435a-9af4-8f12b9eed069`): `theorem _ (z₁ z₂ : ℂ) : starRingEnd ℂ (z₁ * z₂) = starRingEnd ℂ z₁ * starRingEnd ℂ z₂`
  - theirs `Sum_of_Complex_Conjugates` by **Community (Bot)** (`393ff6c5-2a04-4c58-9c97-2c11931e1a53`): `theorem _ (z₁ z₂ : ℂ) : starRingEnd ℂ (z₁ + z₂) = starRingEnd ℂ z₁ + starRingEnd ℂ z₂`
* ours `BookProof.NavierStokesFlow.DiffHashimoto.half_cast` (`1319c85e-8c73-44ca-bbf4-bc4e086731de`)
  - `theorem _ : (((1 / 2 : ℝ) : ℂ)) = (1 : ℂ) / 2`
  - theirs `mme_entropy_surplus_arith` by **WillR** (`cf6fdb68-c5b0-4c40-9ea0-70f66890ea30`): `theorem _ : ((49 : ℕ) : ℝ) < ((5 : ℕ) : ℝ) * (((25 : ℕ) : ℝ) ^ ((3952233 : ℝ) / 5000000))`
  - theirs `WorkbookSource.plus_18240` by **wamlart** (`72fcbd53-f475-4970-ae5a-1a5e6e1cbff9`): `theorem _ : (6!)^5! ∣ (6!)!`
  - theirs `WorkbookSource.base_56627` by **wamlart** (`f225f584-6308-4a4c-afa4-9dd8ffede92d`): `theorem _ : (2:ℝ) ^ 2002 * 2002! < 2003 ^ 2002`

## D. Reuse shortlist — another user's Proved node with our leaf name

* `BookProof.ChapterSirkDiffusiveDecay.norm_heatFlow_le` — other authors: `NavierStokes.norm_heatFlow_le`/korbonits
* `BookProof.ChapterH1.phi_zero` — other authors: `PythHydra.phi_zero`/raver1975

## E. Platform-wide duplicate backlog (context)

The scan finds **6137** statement-duplicate groups, **290** across authors. None of our solved theorems is in an exact cross-author group, but the backlog is real and is the pool a future wave should import from rather than re-prove. The reusable *instruments* for the new Faris–Lavine / Fock work (Fourier/Parseval, convolution symmetry, Schur row bounds, coercivity, singular-value norm, `H^s` form domain) are listed with ids in the timepiece `CONSOLIDATED_PLAN.md`, §“Cross-platform reuse”.

## F. The theorems already in the pipeline — does any restate an existing node?

Same matcher, applied to every `Theorems/Thm_*.lean` stub named in `pipeline/wave_upload.json` (`debug/find_duplicates.py --report`). This is the **avoid duplication in prove2me** check for the incoming work: a wave theorem that already exists on the platform should be re-published as a reduction, not re-proved.

* wave theorems parsed: **1674**; already present under their own dotted name: **1270**; live pending frontier: **404**.
* local statements are hashed from the **declaration** (`decl_only`), matching the platform's `formal_statement`; see the correction below.

| class | collisions | with a `Proved` node |
| :-- | --: | --: |
| `STMT` | 6 | 6 |
| `DECL` | 0 | 0 |
| `SIG` | 1310 | 921 |
| `SHAPE` | 87 | 87 |
| `NAME` | 0 | 0 |
| `LEAF` | 140 | 138 |

The only non-trivial classes:

* `STMT` — ours `BookProof_YangMillsHermite_gaussInt_sub` → `BookProof.QgHermiteFriedrichs.gaussInt_sub` [Proved/leonardopedro] (`91fe1f87-581a-4019-9430-f07bacf117d7`)
* `STMT` — ours `BookProof_QgHermiteFriedrichs_cpoly_add` → `BookProof.HermiteQuadraticEsa.cpoly_add` [Proved/leonardopedro] (`e81100ec-1be6-45b4-bfcc-4ba4ca80eedc`)
* `STMT` — ours `BookProof_QgHermiteFriedrichs_gaussInt_sub` → `BookProof.YangMillsHermite.gaussInt_sub` [Proved/leonardopedro] (`b9e1ba6f-765c-462f-b5b3-373a30eb7679`)
* `STMT` — ours `BookProof_HermiteQuadraticEsa_cpoly_add` → `BookProof.QgHermiteFriedrichs.cpoly_add` [Proved/leonardopedro] (`a624b3ee-515c-4a8d-a138-70b628ac87bf`)
* `STMT` — ours `BookProof_NavierStokesFlow_nsHamiltonian_hasZeroDeficiencyOn` → `BookProof.NavierStokesFlow.nsHamiltonian_hasZeroDeficiencyOn_of_flow` [Proved/leonardopedro] (`dedaa307-ee1f-4cb9-8b51-8fdf1ab6dc40`)
* `STMT` — ours `BookProof_ChapterParityMajoranaQuant_J_unitary'` → `BookProof.ChapterParityMajoranaQuant.J_unitary_prime` [Proved/leonardopedro] (`af3fc4ae-f0c2-4c64-b927-600c5593dd8d`)

Cross-author `LEAF` hits with a non-generic leaf name: **23** (the rest are false positives on generic leaves such as `add`, `car`, `sum`):

* `BookProof.ChapterSirkDiffusiveDecay.norm_heatFlow_le` ≈ `NavierStokes.norm_heatFlow_le` by **korbonits** (`88931298-072a-4967-8cad-f09e15b5d75d`) — `namespace NavierStokes theorem norm_heatFlow_le {ν : ℝ} (hν : 0 < ν) (t : ℝ) {f : Vec 3 → Vec 3} {M : ℝ} (hM : ∀ y, ‖f y`
* `BookProof.ChapterH1.phi_zero` ≈ `PythHydra.phi_zero` by **raver1975** (`0e291c0d-f2f8-4f88-aa2a-59bc0d935bbe`) — `theorem _(k : ℕ) : phi k 0 = 1`
* `BookProof.HermiteQuadraticEsa.abs_coord_le_norm` ≈ `QFS.abs_coord_le_norm` by **dbenbenn** (`9fed8780-d3ea-4228-820b-252f6afb439a`) — `lemma _ (x : EuclideanSpace ℝ (Fin d)) (i : Fin d) : |x i| ≤ ‖x‖`
* `BookProof.HermiteBand.Band.comp` ≈ `QuasiSymmetricComposition.AntilipschitzOnWith.comp` by **raver1975** (`f90f2923-cd05-4d60-bf43-60e706434173`) — `theorem _{Kg Kf : ℝ≥0} {g : Y → Z} {f : X → Y} {t : Set Y} (hg : AntilipschitzOnWith Kg g t) (hf : AntilipschitzOnWith K`
* `BookProof.HermiteBand.Band.comp` ≈ `OpenGA.MetricFamilyRegularOn.comp` by **Xinze-Li-Moqian** (`c76e06c6-b15b-4e6b-afa0-4decdee487dc`) — `theorem _ {g : ℝ → SmoothRiemannianMetric I M} {U : Set ℝ} (hg : MetricFamilyRegularOn g U) (r : ℝ → ℝ) (hr : ContDiff ℝ`
* `BookProof.HermiteBand.Band.comp` ≈ `CerednikDrinfeld.FormalODModule.HasKernelOfDegree.comp` by **Claude** (`d878e7c0-8471-54f2-bba0-704edc82c8fb`) — `theorem _ {B : Type} [CommRing B] [IsNoetherianRing B] {φ ψ : Series B} {d e : ℕ} (hφ0 : ∀ i, MvPowerSeries.constantCoef`
* `BookProof.HermiteBand.Band.mono` ≈ `CWorldFiltration.walk.mono` by **raver1975** (`ad2df3f9-f29b-40da-8737-1bee3e52ecbe`) — `theorem _(htop : ∀ p : P, p ≤ tp) {s s' : ℕ → Bool} (hss : ∀ l, s l = true → s' l = true) (i : ℕ) : walk t r tp s i ≤ wa`
* `BookProof.HermiteBand.Band.mono` ≈ `EmlClass.mono` by **raver1975** (`5e1390ec-5329-4322-be60-520c91d0598c`) — `theorem _: ∀ {m n : ℕ} {f : ℝ → ℝ}, m ≤ n → EmlClass m f → EmlClass n f`
* `BookProof.HermiteBand.Band.mono` ≈ `TriangularForest.IsTriangularForest.mono` by **raver1975** (`739deed8-16a9-4e6b-b162-52c2bf93e105`) — `theorem _(hle : H ≤ G) (hG : IsTriangularForest G) : IsTriangularForest H`
* `BookProof.HermiteBand.Band.mono` ≈ `TropicalSocialChoice.IsTropLinear.mono` by **raver1975** (`bb2de74f-7c1d-41d8-b030-dd767ef9c04a`) — `theorem _{f : (Fin n → TR) → TR} (hf : IsTropLinear f) {x y : Fin n → TR} (h : ∀ i, x i ≤ y i) : f x ≤ f y`
* `BookProof.HermiteBand.Band.mono` ≈ `B3Free.WeakFree.mono` by **raver1975** (`056c828a-a424-4b14-a492-326633208175`) — `theorem _{F G : Finset (Finset α)} {P : Type*} [Preorder P] (h : WeakFree G P) (hFG : F ⊆ G) : WeakFree F P`
* `BookProof.HermiteBand.Band.mono` ≈ `B3Free.StrongFree.mono` by **raver1975** (`b21d7b3e-9ed8-446b-8c4e-2b60eb7749a5`) — `theorem _{F G : Finset (Finset α)} {P : Type*} [Preorder P] (h : StrongFree G P) (hFG : F ⊆ G) : StrongFree F P`
* `BookProof.HermiteBand.Band.mono` ≈ `ShiShallow.IsLocal.mono` by **Goku** (`41daa660-7dfa-40bf-b89a-53262b86ba66`) — `theorem _ {n : ℕ} {S S' : Finset (Fin n)} {A : Op n} (hSS : S ⊆ S') (h : IsLocal S A) : IsLocal S' A`
* `BookProof.HermiteBand.Band.mono` ≈ `Batch3N9.Problem97.ConvexIndep.mono` by **transmogrifier** (`87637d19-ee4c-44d5-a972-6145af7cb6c8`) — `theorem _ {A B : Finset ℝ²} (hBA : B ⊆ A) (hA : ConvexIndep A) : ConvexIndep B`
* `BookProof.HermiteBand.Band.mono` ≈ `ChebotarevGeodesic.HasErrorExponent.mono` by **raver1975** (`e637eae2-bbaf-4605-990f-4487e83188c4`) — `theorem _(h : HasErrorExponent π M θ) (hle : θ ≤ θ') : HasErrorExponent π M θ'`
* `BookProof.HermiteBand.Band.mono` ≈ `PNTA.HasSimplePolesOn.mono` by **Community (Bot)** (`769b4cda-0f88-42c7-a9f9-ba157146d5a4`) — `theorem _ {f : ℂ → ℂ} {s t : Set ℂ} (h : HasSimplePolesOn f t) (hst : s ⊆ t) : HasSimplePolesOn f s`
* `BookProof.HermiteBand.Band.mono` ≈ `PNTA.HasSimplePolesOn.mono` by **Community (Bot)** (`97ee15db-93fb-4fe5-ac11-38717a59ab1b`) — `theorem _ {f : ℂ → ℂ} {s t : Set ℂ} (h : HasSimplePolesOn f t) (hst : s ⊆ t) : HasSimplePolesOn f s`
* `BookProof.HermiteBand.IsBand1.comp` ≈ `QuasiSymmetricComposition.AntilipschitzOnWith.comp` by **raver1975** (`f90f2923-cd05-4d60-bf43-60e706434173`) — `theorem _{Kg Kf : ℝ≥0} {g : Y → Z} {f : X → Y} {t : Set Y} (hg : AntilipschitzOnWith Kg g t) (hf : AntilipschitzOnWith K`
* `BookProof.HermiteBand.IsBand1.comp` ≈ `OpenGA.MetricFamilyRegularOn.comp` by **Xinze-Li-Moqian** (`c76e06c6-b15b-4e6b-afa0-4decdee487dc`) — `theorem _ {g : ℝ → SmoothRiemannianMetric I M} {U : Set ℝ} (hg : MetricFamilyRegularOn g U) (r : ℝ → ℝ) (hr : ContDiff ℝ`
* `BookProof.HermiteBand.IsBand1.comp` ≈ `CerednikDrinfeld.FormalODModule.HasKernelOfDegree.comp` by **Claude** (`d878e7c0-8471-54f2-bba0-704edc82c8fb`) — `theorem _ {B : Type} [CommRing B] [IsNoetherianRing B] {φ ψ : Series B} {d e : ℕ} (hφ0 : ∀ i, MvPowerSeries.constantCoef`
* `BookProof.NavierStokesFlow.DifferentialL2.Intertwined.comp` ≈ `QuasiSymmetricComposition.AntilipschitzOnWith.comp` by **raver1975** (`f90f2923-cd05-4d60-bf43-60e706434173`) — `theorem _{Kg Kf : ℝ≥0} {g : Y → Z} {f : X → Y} {t : Set Y} (hg : AntilipschitzOnWith Kg g t) (hf : AntilipschitzOnWith K`
* `BookProof.NavierStokesFlow.DifferentialL2.Intertwined.comp` ≈ `OpenGA.MetricFamilyRegularOn.comp` by **Xinze-Li-Moqian** (`c76e06c6-b15b-4e6b-afa0-4decdee487dc`) — `theorem _ {g : ℝ → SmoothRiemannianMetric I M} {U : Set ℝ} (hg : MetricFamilyRegularOn g U) (r : ℝ → ℝ) (hr : ContDiff ℝ`
* `BookProof.NavierStokesFlow.DifferentialL2.Intertwined.comp` ≈ `CerednikDrinfeld.FormalODModule.HasKernelOfDegree.comp` by **Claude** (`d878e7c0-8471-54f2-bba0-704edc82c8fb`) — `theorem _ {B : Type} [CommRing B] [IsNoetherianRing B] {φ ψ : Series B} {d e : ℕ} (hφ0 : ∀ i, MvPowerSeries.constantCoef`

Triaged: `QFS.abs_coord_le_norm` (dbenbenn) is **not** a reuse — timepiece's own `v4.28.0` Mathlib proves it as `PiLp.norm_apply_le` with `Real.norm_eq_abs`; the leaf match is a naming coincidence. The other two are different statements under a shared leaf (`NavierStokes.norm_heatFlow_le` is a 3-D vector heat-flow bound vs. our generic `E/F` one; `PythHydra.phi_zero` is `phi k 0 = 1` vs. our `phi 0 = Complex.exp`).

**Correction (2026-09-18).**  Up to and including the previous run this table was misleading: the *local* side was hashed from the whole stub file — `import`/`open` prologue included — while the platform side is hashed from `formal_statement`, which is the bare declaration. The two objects were never comparable, so `STMT`/`SIG`/`SHAPE` could not fire and the `0` in the `STMT` row read as a clean bill of health when it was an artifact of the mismatch. `local_theorems` now hashes `decl_only(...)`, as it always hashed `dh`, and the same classes report **6 / 1310 / 87** collisions.

* **6** of them are exact restatements (`STMT`), **all against our own** nodes — the cross-author `STMT` count is 0.
* Most are already resolved by the pipeline's own reuse detection: the publish-job sync marks them `reused: true` with the id of the existing node (`reused_status: published` for the theorem, `Proved` for the solution) instead of minting a twin. `PIPELINE_PLAN.md` §1y lists the six and the two that are still open.
* `SIG`/`SHAPE` are triage lists, not verdicts: they compare identifier *sets*, so statements sharing API names (`structureConstant_antisymm_swap` / `_rotate` / `jacobi`) collide without being restatements.

**Conclusion.** No wave theorem restates **another user's** node in any class, so there is no pipeline item to re-publish as a cross-author reduction. The reusable material for the *new* Faris–Lavine / Fock work is the instrument table of `CONSOLIDATED_PLAN.md` §“Cross-platform reuse”, not a wave-node twin. What the wave *does* contain is a handful of **self**-restatements (two chapters of ours stating one lemma), which the `SHAPE` class now catches before a stub is generated rather than after.

## G. Alpha-renamed restatements of an already-`Proved` node

The classes above compare token sets *including* the binder names, which is blind to the commonest way a new chapter duplicates an old node: the same statement with renamed variables. Two spellings slip through in particular — single-letter names (`b`, `g`) are identifiers to the tokenizer and stay in the set, while **Greek names (`β`, `γ`) are not matched by it at all** and silently disappear, so `sig` and `STMT` compare two spellings of one theorem as different strings. The `SHAPE` row above (identifier set with all single-character names dropped, `debug/find_duplicates.py: shape`) closes that gap.

Of the **404** not-yet-published wave theorems, **4** restate a `Proved` node up to binder renaming: **4** against one of our own nodes and **0** against another user's.

* ours `BookProof.NavierStokesFlow.FarisLavineLift.norm_inner_commutator_sum_le'`
  - restates `BookProof.NavierStokesFlow.FarisLavineLift.norm_inner_commutator_sum_le` — **ours**, `b96391f9-c91d-427b-a832-5fa3e001541d`: `theorem _ (s : Finset κ) (h n : κ → (D →ₗ[ℂ] D)) (c₂ : ℝ) (hc₂ : 0 ≤ c₂) (v : D) (hcomm : ∀ k ∈ s, ∀ l ∈ s, k ≠ l → (h k).comp (n l) = (n l)`
* ours `BookProof.ChapterH9.krylov_bestApprox_tendsto_zero`
  - restates `BookProof.YangMillsFriedrichs.weylKrylov_bestApprox_tendsto_zero` — **ours**, `de41118f-a7a1-49d1-b27f-8bbcb922e685`: `theorem _ (H : E →ₗ[ℂ] E) (v u : E) (hdense : Dense ((⨆ k : ℕ, krylovSpan H v k : Submodule ℂ E) : Set E)) : Filter.Tendsto (fun k : ℕ => ‖u`
* ours `BookProof.NavierStokesFlow.DifferentialL2.crd_coreState`
  - restates `BookProof.NavierStokesFlow.LagrangianCanonical.crd_coreState` — **ours**, `a6836d1e-a09e-4a0d-abf4-455922b9d3f9`: `theorem _ (β γ : Vel) : crd (coreState β) γ = if γ = β then 1 else 0`
* ours `BookProof.NavierStokesFlow.nsHamiltonian_hasZeroDeficiencyOn`
  - restates `BookProof.NavierStokesFlow.nsHamiltonian_hasZeroDeficiencyOn_of_flow` — **ours**, `dedaa307-ee1f-4cb9-8b51-8fdf1ab6dc40`: `theorem _ : HasZeroDeficiencyOn (⊤ : Submodule ℂ (EuclideanSpace ℂ (Fin n))) (restrictToTop (Matrix.toEuclideanLin (nsHamiltonian d)))`

**Action.** These need no new proof and no new node: they are the same claim, so the pipeline should resolve them as already present rather than re-submitting (the publish-job sync already records them as `reused: true` with the id of the existing node — `reused_status: published`; see `PIPELINE_PLAN.md` §1n/§1y). The `SHAPE` check exists so the *generator* can skip a restatement before it becomes a stub, instead of after.

## Method and caveats

* Ground truth for “proved by us” is `GET /users/<uid>` → `solved_problems` (PIPELINE_PLAN.md §1g/§1h). `created_by` alone over-counts (a node we published Open can be Proved later by anyone), and `GET /submissions` is a truncated window.
* Statements are compared **name-stripped**: the platform stores `theorem <full.name> <binders> : <type> := by sorry`, so the module name is removed before hashing; otherwise every equality would be a name equality. Definitions (empty statements) are excluded.
* Catalogue was indexed once in the default environment; paging returned 73968 distinct rows of a reported total, so a small overlap across pages is possible and coverage is close to complete but not provably exhaustive.
* The matcher is **syntactic**: it does not know that two statements are logically equivalent under different casts/coercions, nor that one implies the other. Treat “near” as a triage list, not a verdict.
* `SIG` keeps the binder names, so despite its docstring it is *not* binder-insensitive; `SHAPE` is, but it drops every single-character identifier, so it matches on the multi-letter API names alone and needs a read. Neither class sees through `PiLp`/coercion restatements, which is why `QFS.abs_coord_le_norm` above is a leaf-only hit.
* The catalogue is a snapshot of the default environment: a theorem published after the index was built is invisible to every class here. Refresh with `--reset --index` before treating a zero as final.
* Re-run after each upload wave: `python3 debug/find_duplicates.py --reset --index` (in bounded chunks) then `python3 debug/dedup_report.py`.
