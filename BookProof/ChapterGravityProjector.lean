import Mathlib

/-!
# Chapter — Diffeomorphisms and gravity: the spatial projector `χ = δ + v⊗v`

Source: `book.tex`, chapter *"Diffeomorphisms and gravity"*, §*"Classical
Hamiltonian"* (line ~8091).  In the Einstein–Cartan / teleparallel Hamiltonian
formalism the author introduces, relative to a globally defined **unit timelike
vector** `v` (`vᵘ vᵤ = −1` in the mostly-plus Minkowski metric
`η = diag(−1,1,1,1)`), the mixed tensor

`χ_a{}^b = δ_a{}^b + v_a v^b`,

which is used pervasively to decompose all the torsion tensors into their
spatial (`3`-dimensional) and temporal parts.  This `χ` is exactly the
**orthogonal projector onto the spatial hyperplane** `v^⊥`: it annihilates `v`,
is idempotent, has trace `3` (it is a rank-`3` projector, the spatial slice), and
acts as the identity on vectors orthogonal to `v`.

This file makes those self-contained linear-algebra facts precise, modelling the
`(1,1)` tensor `χ^a{}_b = δ^a{}_b + v^a v_b` (raising the free index so it acts
on contravariant vectors) as an explicit `4×4` real matrix.

Formalized here (all under the physical unit-timelike hypothesis
`minkSq v = -1`, i.e. `−v₀² + v₁² + v₂² + v₃² = −1`):

* `metric` — the Minkowski metric `η = diag(−1,1,1,1)`;
* `lower v` — index lowering `v_a = η_{ab} v^b`;
* `minkSq v` — the Minkowski square `v^a v_a`;
* `spatialProj v` — the projector `χ^a{}_b = δ^a{}_b + v^a v_b`;
* `spatialProj_mulVec_self` — `χ` annihilates `v` (`v` spans the kernel);
* `spatialProj_idempotent` — `χ² = χ` (it is a genuine projector);
* `trace_spatialProj` — `tr χ = 3` (rank `3`: the spatial slice);
* `spatialProj_mulVec_of_orthogonal` — `χ` is the identity on `v^⊥`, so it is the
  orthogonal projection onto the spatial hyperplane.

Everything is `sorry`-free and `axiom`-free (only `propext`, `Classical.choice`,
`Quot.sound`); no `EXTERNAL` hypothesis, no `axiom`.
-/

namespace BookProof.ChapterGravityProjector

open Matrix
open scoped BigOperators

/-- The Minkowski metric `η = diag(−1, 1, 1, 1)` (mostly-plus convention). -/
noncomputable def metric : Matrix (Fin 4) (Fin 4) ℝ :=
  Matrix.diagonal (fun i => if i = 0 then -1 else 1)

/-- Index lowering `v_a = η_{ab} v^b`. -/
noncomputable def lower (v : Fin 4 → ℝ) : Fin 4 → ℝ := metric.mulVec v

/-- The Minkowski square `v^a v_a = η_{ab} v^a v^b`. -/
noncomputable def minkSq (v : Fin 4 → ℝ) : ℝ := ∑ a, v a * lower v a

/-- The spatial projector `χ^a{}_b = δ^a{}_b + v^a v_b`, as a `4×4` matrix acting
on contravariant vectors. -/
noncomputable def spatialProj (v : Fin 4 → ℝ) : Matrix (Fin 4) (Fin 4) ℝ :=
  1 + Matrix.of (fun a b => v a * lower v b)

/-
`χ` annihilates the timelike vector `v`: `χ v = 0`, so `v` spans the kernel
of the spatial projector.
-/
theorem spatialProj_mulVec_self (v : Fin 4 → ℝ) (hv : minkSq v = -1) :
    (spatialProj v).mulVec v = 0 := by
  ext a;
  simp only [mulVec, dotProduct, spatialProj, add_apply, of_apply, Pi.zero_apply];
  simp_all only [minkSq, lower, add_mul, mul_assoc, Finset.sum_add_distrib];
  simp_all only [one_apply, mul_comm, mul_ite, mul_one, mul_zero, Finset.sum_ite_eq,
      Finset.mem_univ, ↓reduceIte];
  rw [ ← Finset.mul_sum _ _ _, hv ] ; ring

/-
`χ` is idempotent: `χ² = χ`, i.e. it is a genuine projector.
-/
theorem spatialProj_idempotent (v : Fin 4 → ℝ) (hv : minkSq v = -1) :
    spatialProj v * spatialProj v = spatialProj v := by
  -- M*M at (a,b) = ∑_c (v a * lower v c)(v c * lower v b) = v a * lower v b * (∑_c lower v c * v c)
  have hM2 : ∀ a b, (∑ c, (v a * lower v c) * (v c * lower v b)) = -(v a * lower v b) := by
    simp_all [ minkSq, lower, Fin.sum_univ_four ];
    grind;
  ext a b;    simp [ *, Matrix.mul_apply ] ;    ring;
  simp_all [ spatialProj ] ; ring;
  simp_all [ Finset.sum_add_distrib, mul_assoc, Matrix.one_apply ] ; ring

/-
`χ` has trace `3`: it is a rank-`3` projector (the `3`-dimensional spatial
slice orthogonal to `v`).
-/
theorem trace_spatialProj (v : Fin 4 → ℝ) (hv : minkSq v = -1) :
    (spatialProj v).trace = 3 := by
  unfold spatialProj; norm_num [ minkSq, Matrix.mulVec, Matrix.trace ] at *;
  norm_num [ Finset.sum_add_distrib, hv ]

/-
`χ` acts as the identity on vectors orthogonal to `v` (`v_a x^a = 0`), so it
is the orthogonal projection onto the spatial hyperplane `v^⊥`.
-/
theorem spatialProj_mulVec_of_orthogonal (v x : Fin 4 → ℝ)
    (hx : ∑ a, lower v a * x a = 0) :
    (spatialProj v).mulVec x = x := by
  simp_all [ spatialProj, Matrix.mulVec, funext_iff ];
  simp_all [ Matrix.one_apply, dotProduct ];
  simp_all [ Finset.sum_add_distrib, add_mul ];
  simp_all [ mul_assoc, ← Finset.mul_sum _ _ _ ]

end BookProof.ChapterGravityProjector
