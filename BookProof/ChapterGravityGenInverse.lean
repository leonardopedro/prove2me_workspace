import Mathlib
import BookProof.ChapterGravityProjector
import BookProof.ChapterGravityMetric
import BookProof.ChapterGravityInvMetric

/-!
# Chapter — Diffeomorphisms and gravity: `h` and `h♯` are a generalized-inverse pair

Source: `book.tex`, chapter *"Diffeomorphisms and gravity"*, §*"Classical
Hamiltonian"* (line ~8091).  Continuing the standing directive (mine the next
self-contained mathematical claim from `book.tex`) and building directly on the
induced spatial metric `h_{ab} = η_{ab} + v_a v_b` (`ChapterGravityMetric`,
Wave 70) and its raised counterpart `h^{ab} = η^{ab} + v^a v^b`
(`ChapterGravityInvMetric`, Wave 72), this file shows that the *degenerate*
metric pair `(h, h♯)` behaves as a **generalized (Moore–Penrose-type) inverse
pair** on the spatial hyperplane `v^⊥`: even though neither factor is invertible
(both degenerate along the time direction `v`, with `minkSq v = −1`), they satisfy
the two defining absorption identities

`h · h♯ · h = h`   and   `h♯ · h · h♯ = h♯`,

with the mixed products being the complementary projectors of the `3+1` split.
This is the precise linear-algebra sense in which `h♯` inverts `h` on the spatial
slice.  Everything reuses `metric`, `lower`, `minkSq`, `spatialProj`,
`spatialProj_idempotent` from `ChapterGravityProjector`, `spatialMetric`,
`spatialMetric_eq_metric_mul_proj` from `ChapterGravityMetric`, and
`invSpatialMetric`, `invSpatialMetric_mulVec_lower_self`,
`invSpatialMetric_mul_spatialMetric` from `ChapterGravityInvMetric`.

Formalized here (all under the physical unit-timelike hypothesis
`minkSq v = -1`):

* `spatialMetric_mul_spatialProj` — `h · χ = h` (χ acts as identity on the image
  of `h`);
* `spatialProj_mul_invSpatialMetric` — `χ · h♯ = h♯` (χ acts as identity on the
  image of `h♯`);
* `spatialMetric_genInverse` — **headline** `h · h♯ · h = h`;
* `invSpatialMetric_genInverse` — **headline** `h♯ · h · h♯ = h♯`.

Everything is `sorry`-free and `axiom`-free (only `propext`, `Classical.choice`,
`Quot.sound`); no `EXTERNAL` hypothesis, no `axiom`.
-/

namespace BookProof.ChapterGravityGenInverse

open Matrix
open scoped BigOperators
open BookProof.ChapterGravityProjector
open BookProof.ChapterGravityMetric
open BookProof.ChapterGravityInvMetric

/-
`h · χ = h`: the spatial projector `χ` is the identity on the image of the
induced spatial metric.  Since `h = η · χ` and `χ` is idempotent,
`h · χ = η · χ · χ = η · χ = h`.
-/
theorem spatialMetric_mul_spatialProj (v : Fin 4 → ℝ) (hv : minkSq v = -1) :
    spatialMetric v * spatialProj v = spatialMetric v := by
  rw [BookProof.ChapterGravityMetric.spatialMetric_eq_metric_mul_proj, mul_assoc,
    BookProof.ChapterGravityProjector.spatialProj_idempotent v hv]

/-
`χ · h♯ = h♯`: the spatial projector `χ` is the identity on the image of the
raised spatial metric.  Equivalently `(χ − 1) · h♯ = (v ⊗ v♭) · h♯ = 0`, which
holds because `h♯` annihilates the lowered timelike covector
(`invSpatialMetric_mulVec_lower_self`).
-/
theorem spatialProj_mul_invSpatialMetric (v : Fin 4 → ℝ) (hv : minkSq v = -1) :
    spatialProj v * invSpatialMetric v = invSpatialMetric v := by
  ext a c;    simp only [spatialProj, mul_apply, add_apply, one_apply, of_apply, Fin.sum_univ_four,
                Fin.isValue] ; ring;
  have h_sum_zero : ∑ b, lower v b * (invSpatialMetric v) b c = 0 := by
    convert congr_arg ( fun x => x c ) (
        BookProof.ChapterGravityInvMetric.invSpatialMetric_mulVec_lower_self v hv ) using 1;
    simp only [mul_comm, mulVec, dotProduct];
    exact Finset.sum_congr rfl fun _ _ => by
      rw [ show invSpatialMetric v _ _ = invSpatialMetric v _ _ from
        congr_fun ( congr_fun ( BookProof.ChapterGravityInvMetric.invSpatialMetric_symm v ) _ ) _ ]
  fin_cases a <;> simp_all only [Fin.sum_univ_four, Fin.isValue, Fin.zero_eta, ↓reduceIte, one_mul,
                    zero_ne_one, zero_mul, add_zero, Fin.reduceEq, Fin.mk_one,
                    one_ne_zero, zero_add, add_eq_right, Fin.reduceFinMk] <;> ring!;
  · linear_combination' h_sum_zero * v 0;
  · linear_combination' h_sum_zero * v 1;
  · linear_combination' h_sum_zero * v 2;
  · linear_combination' h_sum_zero * v 3

/-
**Headline.** The absorption identity `h · h♯ · h = h`: the pair `(h, h♯)` is a
generalized inverse pair for `h`.  Using `h♯ · h = χ` and `h · χ = h`,
`h · h♯ · h = h · (h♯ · h) = h · χ = h`.
-/
theorem spatialMetric_genInverse (v : Fin 4 → ℝ) (hv : minkSq v = -1) :
    spatialMetric v * invSpatialMetric v * spatialMetric v = spatialMetric v := by
  grind +suggestions

/-
**Headline.** The absorption identity `h♯ · h · h♯ = h♯`: the pair `(h, h♯)` is a
generalized inverse pair for `h♯`.  Using `h♯ · h = χ` and `χ · h♯ = h♯`,
`h♯ · h · h♯ = (h♯ · h) · h♯ = χ · h♯ = h♯`.
-/
theorem invSpatialMetric_genInverse (v : Fin 4 → ℝ) (hv : minkSq v = -1) :
    invSpatialMetric v * spatialMetric v * invSpatialMetric v = invSpatialMetric v := by
  rw [ BookProof.ChapterGravityInvMetric.invSpatialMetric_mul_spatialMetric v hv,
      BookProof.ChapterGravityGenInverse.spatialProj_mul_invSpatialMetric v hv ]

end BookProof.ChapterGravityGenInverse
