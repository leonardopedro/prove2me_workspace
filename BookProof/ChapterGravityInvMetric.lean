import Mathlib
import BookProof.ChapterGravityProjector
import BookProof.ChapterGravityMetric

/-!
# Chapter — Diffeomorphisms and gravity: the inverse (raised) spatial metric `h♯ = η + v⊗v`

Source: `book.tex`, chapter *"Diffeomorphisms and gravity"*, §*"Classical
Hamiltonian"* (line ~8091).  Continuing the standing directive (mine the next
self-contained mathematical claim from `book.tex`) and building directly on
`ChapterGravityProjector` (Wave 69) and `ChapterGravityMetric` (Wave 70), we
treat the **inverse spatial metric** obtained by raising both indices of the
induced spatial metric `h_{ab} = η_{ab} + v_a v_b`:

`h^{ab} = η^{ab} + v^a v^b`.

Relative to a globally defined **unit timelike vector** `v`
(`minkSq v = −1` in the mostly-plus Minkowski metric `η = diag(−1,1,1,1)`),
`h^♯` is the metric induced on the cotangent spatial hyperplane.  Since the
Minkowski metric is an involution (`η^{ab} = η_{ab}`, so `η² = 1`), the raised
and lowered spatial metrics compose to the spatial **projector** `χ`, the
hallmark of a (degenerate) inverse metric pair.  This file records those
self-contained linear-algebra facts, reusing `metric`, `lower`, `minkSq`,
`spatialProj` from `ChapterGravityProjector` and `spatialMetric` from
`ChapterGravityMetric`.

Formalized here (all under `minkSq v = -1` where noted):

* `invSpatialMetric v` — the symmetric matrix `h^{ab} = η^{ab} + v^a v^b`;
* `metric_mul_metric` — the Minkowski metric is an involution, `η · η = 1`
  (so `η` is its own inverse: `η^{ab} η_{bc} = δ^a{}_c`);
* `invSpatialMetric_symm` — `h^♯` is symmetric (`(h♯)ᵀ = h♯`);
* `invSpatialMetric_mulVec_lower_self` — `h^♯` annihilates the lowered vector
  `v_a` (`h^{ab} v_b = 0`): the inverse metric degenerates along the time
  covector, complementary to `h_{ab} v^b = 0`;
* `invSpatialMetric_mul_spatialMetric` — **headline**: `h^♯ · h = χ`, the raised
  and lowered spatial metrics compose to the spatial projector `χ^a{}_b`
  (identity on `v^⊥`), the defining relation of an inverse-metric pair on the
  degenerate hyperplane.

Everything is `sorry`-free and `axiom`-free (only `propext`, `Classical.choice`,
`Quot.sound`); no `EXTERNAL` hypothesis, no `axiom`.
-/

namespace BookProof.ChapterGravityInvMetric

open Matrix
open scoped BigOperators
open BookProof.ChapterGravityProjector
open BookProof.ChapterGravityMetric

/-- The inverse (raised) spatial `(2,0)` metric `h^{ab} = η^{ab} + v^a v^b`. -/
noncomputable def invSpatialMetric (v : Fin 4 → ℝ) : Matrix (Fin 4) (Fin 4) ℝ :=
  metric + Matrix.of (fun a b => v a * v b)

/-
The Minkowski metric is an involution: `η · η = 1`.  Equivalently `η^{ab}` (=
`η_{ab}` numerically) is its own inverse, `η^{ab} η_{bc} = δ^a{}_c`.
-/
theorem metric_mul_metric : metric * metric = 1 := by
  ext i j; fin_cases i <;> fin_cases j <;> simp [ metric ] ;

/-
`h^♯` is symmetric.
-/
theorem invSpatialMetric_symm (v : Fin 4 → ℝ) :
    (invSpatialMetric v)ᵀ = invSpatialMetric v := by
      ext i j; simp only [invSpatialMetric, transpose_apply, add_apply, of_apply, mul_comm,
          add_left_inj] ;
      fin_cases i <;> fin_cases j <;> rfl

/-
`h^♯` annihilates the lowered timelike covector `v_a = lower v a`
(`h^{ab} v_b = 0`): the inverse spatial metric is degenerate exactly along the
time covector, complementary to `h_{ab} v^b = 0`.
-/
theorem invSpatialMetric_mulVec_lower_self (v : Fin 4 → ℝ) (hv : minkSq v = -1) :
    (invSpatialMetric v).mulVec (lower v) = 0 := by
      convert spatialProj_mulVec_self v hv using 1;
      unfold invSpatialMetric spatialProj;        ext; simp only [mulVec, dotProduct, add_apply,
                                                         of_apply,
                                                         Fin.sum_univ_four,
                                                         Fin.isValue] ;
      unfold lower metric; simp only [Fin.isValue, mulVec, dotProduct, Fin.sum_univ_four,
                             diagonal_apply_eq, ↓reduceIte, neg_mul,
                             one_mul, ne_eq, zero_ne_one,
                             not_false_eq_true, diagonal_apply_ne,
                             zero_mul, add_zero, Fin.reduceEq,
                             mul_neg, one_ne_zero, zero_add] ; ring;
      rename_i i; fin_cases i <;> simp [ Matrix.one_apply ]; all_goals ring

/-
**Headline.** The raised and lowered spatial metrics compose to the spatial
projector, `h^♯ · h = χ`: the inverse metric pair acts as the identity on the
spatial hyperplane `v^⊥`.
-/
theorem invSpatialMetric_mul_spatialMetric (v : Fin 4 → ℝ) (hv : minkSq v = -1) :
    invSpatialMetric v * spatialMetric v = spatialProj v := by
      unfold invSpatialMetric spatialMetric spatialProj;
      ext a b; simp [ *, Matrix.mul_apply, Fin.sum_univ_four ] ; ring;
      simp [ Fin.sum_univ_four, Matrix.mulVec, dotProduct, lower, minkSq, metric ] at *;
      simp [ Matrix.one_apply, Matrix.diagonal_apply ] at *;
      grind

end BookProof.ChapterGravityInvMetric
