import Mathlib
import BookProof.ChapterFreeFieldBornCont

/-!
# Chapter "Wave-function parametrization of a probability measure", §5 —
# the Born parametrization is *many-to-one* (gauge redundancy of the sphere)

Source: `book.tex`, Introduction, section *"Wave-function collapse versus Euler's
formula"* (`book.tex` line ~805): *"the wave-function is nothing else than one
possible parametrization of any probability distribution; the parametrization is
a surjective map from an hypersphere to the set of all possible probability
distributions.  **Two wave-functions are always related by a rotation of the
hypersphere** …"* together with the free-field construction of §5 (`book.tex`
~line 1706).

Waves 141–143 (`ChapterFreeFieldBorn`, `ChapterFreeFieldBornSurj`,
`ChapterFreeFieldBornCont`) established that the coordinate-wise Born map
`x ↦ (x_k)²` is a **continuous surjection** of the unit sphere onto the
probability simplex.  This file records the complementary fact that the
parametrization is genuinely **redundant**: the Born map is invariant under the
antipodal map `x ↦ -x` (a sign flip is exactly the real gauge freedom recorded
in `ChapterBornPhaseFiber.born_fiber_real`), and hence — since no point of the
unit sphere is its own antipode — the Born map is *not injective* on the sphere
for `n ≥ 1`.  So the wave-function parametrization is a surjection with genuine
fibers, never a bijection.

## Main results

* `bornMap_neg` — the Born map is antipodal-invariant: `bornMap (-x) = bornMap x`.
* `neg_mem_sphere` — the antipode of a sphere point is again on the sphere.
* **headline** `bornMap_not_injOn_sphere` — for `n ≥ 1` the Born map is *not*
  injective on the unit sphere.
* `bornMap_surjOn_not_injOn_sphere` — packaging: for `n ≥ 1` the Born map is a
  surjection of the sphere onto the simplex that is not injective.

Everything is intended to be `sorry`-free and axiom-clean.
-/

open MeasureTheory
open BookProof.ChapterFreeFieldBorn BookProof.ChapterFreeFieldBornSurj

namespace BookProof.ChapterFreeFieldBornGauge

variable {n : ℕ}

/-- The Born map is invariant under the antipodal map `x ↦ -x`: replacing a wave
function by its negative (a coordinate-wise sign flip, i.e. the real gauge
freedom) leaves the Born probabilities `(x_k)²` unchanged. -/
theorem bornMap_neg (x : EuclideanSpace ℝ (Fin n)) :
    bornMap (-x) = bornMap x := by
  funext k
  change (-(x k)) ^ 2 = (x k) ^ 2
  ring

/-- The antipode of a point on the unit sphere is again on the unit sphere. -/
theorem neg_mem_sphere {x : EuclideanSpace ℝ (Fin n)}
    (hx : x ∈ Metric.sphere (0 : EuclideanSpace ℝ (Fin n)) 1) :
    -x ∈ Metric.sphere (0 : EuclideanSpace ℝ (Fin n)) 1 := by
  rw [Metric.mem_sphere, dist_zero_right, norm_neg]
  rw [Metric.mem_sphere, dist_zero_right] at hx
  exact hx

/-
**Headline.** For `n ≥ 1` the Born map is *not injective* on the unit sphere:
any sphere point `x` and its antipode `-x` are distinct (since `‖x‖ = 1 ≠ 0`, so
`x ≠ 0` and thus `-x ≠ x`) yet have the same Born image.  This is the redundancy
("gauge freedom") of the wave-function parametrization.
-/
theorem bornMap_not_injOn_sphere (hn : 0 < n) :
    ¬ Set.InjOn (bornMap : EuclideanSpace ℝ (Fin n) → _)
        (Metric.sphere (0 : EuclideanSpace ℝ (Fin n)) 1) := by
  haveI : Nonempty (Fin n) := ⟨⟨0, hn⟩⟩
  obtain ⟨x, hx⟩ := (NormedSpace.sphere_nonempty (x := (0 : EuclideanSpace ℝ (Fin n)))
    (r := 1)).2 (by norm_num)
  have hx0 : x ≠ 0 := by
    intro h; rw [h] at hx; simp at hx
  intro hinj
  have hne : -x ≠ x := by
    intro h
    apply hx0
    have : (2 : ℝ) • x = 0 := by
      have := h
      rw [neg_eq_iff_add_eq_zero] at this
      rw [two_smul]; simpa using this
    simpa using this
  exact hne (hinj (neg_mem_sphere hx) hx (bornMap_neg x))

/-
Packaging the full picture on the sphere: for `n ≥ 1` the Born map is a
**surjection onto the simplex that is not injective** — the wave-function
parametrization is genuinely many-to-one.
-/
theorem bornMap_surjOn_not_injOn_sphere (hn : 0 < n) :
    Set.SurjOn (bornMap : EuclideanSpace ℝ (Fin n) → _)
        (Metric.sphere (0 : EuclideanSpace ℝ (Fin n)) 1) (stdSimplex ℝ (Fin n)) ∧
      ¬ Set.InjOn (bornMap : EuclideanSpace ℝ (Fin n) → _)
        (Metric.sphere (0 : EuclideanSpace ℝ (Fin n)) 1) :=
  ⟨bornMap_surjOn_stdSimplex, bornMap_not_injOn_sphere hn⟩

end BookProof.ChapterFreeFieldBornGauge
