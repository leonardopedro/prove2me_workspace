import Mathlib
import BookProof.ChapterFreeFieldSphereSupport

/-!
# Chapter "Wave-function parametrization of a probability measure", §5 —
# the Born pushforward of the Gaussian sphere measure lives on the simplex

Source: `book.tex`, chapter *"Wave-function parametrization of a probability
measure"*, section *"5. Free field parametrization in Bayesian inference and
Statistical Mechanics"* (`book.tex` line ~1706), together with the
Introduction's statement (`book.tex` ~line 805) that *"the wave-function is
nothing else than one possible parametrization of any probability distribution;
the parametrization is a surjective map from an hypersphere to the set of all
possible probability distributions."*

Earlier waves built the *uniform measure on the sphere from the Gaussian*
(`ChapterFreeFieldSphere.sphereGaussian`), showed it is rotation-invariant,
lives on the unit sphere (`ChapterFreeFieldSphereSupport`), and is a fixed point
of re-normalization (`ChapterFreeFieldSphereFixpoint`).  This file connects that
sphere measure to the **Born-rule parametrization** itself: the coordinate-wise
Born map `x ↦ (x_k)²` sends the unit sphere onto the probability simplex, and
hence pushes the Gaussian sphere measure forward to a genuine probability
distribution on the simplex.  This makes precise the book's claim that the
hypersphere parametrizes "the set of all possible probability distributions".

## Main results

* `bornMap` — the Born map `x ↦ fun k => (x k)^2`.
* `bornMap_sum_of_mem_sphere` — on the unit sphere the Born coordinates sum to
  `1`.
* `bornMap_mem_stdSimplex` — the Born image of a unit vector lies in the
  probability simplex `stdSimplex ℝ (Fin n)`.
* **headline** `bornGaussian_stdSimplex_eq_one` — for `n ≥ 1` the Born
  pushforward of the Gaussian sphere measure assigns full mass `1` to the
  probability simplex: `((sphereGaussian n).map bornMap) (stdSimplex ℝ (Fin n))
  = 1`.

Everything is intended to be `sorry`-free and axiom-clean.
-/

open MeasureTheory
open BookProof.ChapterFreeFieldGaussian BookProof.ChapterFreeFieldSphere
open BookProof.ChapterFreeFieldSphereSupport

namespace BookProof.ChapterFreeFieldBorn

variable {n : ℕ}

/-- The **Born map**: sends a wave function `x` to its Born probabilities
`p_k = (x_k)²`. -/
noncomputable def bornMap (x : EuclideanSpace ℝ (Fin n)) : Fin n → ℝ :=
  fun k => (x k) ^ 2

theorem measurable_bornMap : Measurable (bornMap : EuclideanSpace ℝ (Fin n) → _) := by
  unfold bornMap; fun_prop

theorem bornMap_nonneg (x : EuclideanSpace ℝ (Fin n)) (k : Fin n) : 0 ≤ bornMap x k := by
  unfold bornMap; positivity

/-
On the unit sphere the Born coordinates sum to `1`: this is exactly the identity
`‖x‖² = ∑ k (x_k)²` specialised to `‖x‖ = 1`.
-/
theorem bornMap_sum_of_mem_sphere {x : EuclideanSpace ℝ (Fin n)}
    (hx : x ∈ Metric.sphere (0 : EuclideanSpace ℝ (Fin n)) 1) :
    ∑ k, bornMap x k = 1 := by
  have hnorm : ‖x‖ = 1 := by simpa using hx
  rw [EuclideanSpace.norm_eq x, Real.sqrt_eq_one] at hnorm
  unfold bornMap
  rw [← hnorm]
  refine Finset.sum_congr rfl (fun i _ => ?_)
  rw [Real.norm_eq_abs, sq_abs]

/-
The Born image of a unit vector lies in the probability simplex.
-/
theorem bornMap_mem_stdSimplex {x : EuclideanSpace ℝ (Fin n)}
    (hx : x ∈ Metric.sphere (0 : EuclideanSpace ℝ (Fin n)) 1) :
    bornMap x ∈ stdSimplex ℝ (Fin n) :=
  ⟨fun k => bornMap_nonneg x k, bornMap_sum_of_mem_sphere hx⟩

/-
**Headline.** For `n ≥ 1` the Born pushforward of the Gaussian sphere measure
is a genuine probability distribution on the simplex: it assigns the full mass
`1` to `stdSimplex ℝ (Fin n)`.  Indeed `sphereGaussian n` is concentrated on the
unit sphere (`sphereGaussian_sphere_eq_one`), and the Born map sends the sphere
into the simplex (`bornMap_mem_stdSimplex`), so the preimage of the simplex has
full mass.
-/
theorem bornGaussian_stdSimplex_eq_one (hn : 0 < n) :
    ((sphereGaussian n).map bornMap) (stdSimplex ℝ (Fin n)) = 1 := by
  rw [Measure.map_apply measurable_bornMap (isClosed_stdSimplex (Fin n)).measurableSet]
  refine le_antisymm prob_le_one ?_
  calc (1 : ENNReal)
      = sphereGaussian n (Metric.sphere (0 : EuclideanSpace ℝ (Fin n)) 1) :=
        (sphereGaussian_sphere_eq_one hn).symm
    _ ≤ sphereGaussian n (bornMap ⁻¹' stdSimplex ℝ (Fin n)) := by
        apply measure_mono
        intro x hx
        exact bornMap_mem_stdSimplex hx

end BookProof.ChapterFreeFieldBorn
