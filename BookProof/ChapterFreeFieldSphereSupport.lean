import Mathlib
import BookProof.ChapterFreeFieldSphere

/-!
# Chapter "Wave-function parametrization of a probability measure", §5 —
# the Gaussian-built uniform measure really lives on the unit sphere

Source: `book.tex`, chapter *"Wave-function parametrization of a probability
measure"*, section *"5. Free field parametrization in Bayesian inference and
Statistical Mechanics"* (`book.tex` line ~1706):

> "it is well known since many decades that a uniform (Lebesgue-like) measure of
> an infinite-dimensional sphere can be defined using the Gaussian measure and
> the Fock-space."

`ChapterFreeFieldGaussian` proved the standard Gaussian prior is
rotation-invariant, and `ChapterFreeFieldSphere` defined `sphereGaussian`, the
pushforward of that Gaussian under radial normalization `x ↦ ‖x‖⁻¹ • x`, and
proved it too is rotation-invariant.  This file takes the natural **next step**:
it verifies that the constructed measure is *actually a measure on the sphere* —
`sphereGaussian n` gives full mass `1` to the unit sphere (for `n ≥ 1`).  This is
what makes the book's construction a genuine *uniform measure on the sphere*: the
Gaussian has no atom at the origin, so after normalization all the mass lands on
`{x : ‖x‖ = 1}`.

## Main results

* `normalize_mem_sphere` — for `x ≠ 0`, `normalize x` lies on the unit sphere.
* `stdGaussian_singleton` — for `n ≥ 1`, the standard Gaussian is atomless:
  `stdGaussian n {x} = 0`.
* **headline** `sphereGaussian_sphere_eq_one` — for `n ≥ 1`,
  `sphereGaussian n (Metric.sphere 0 1) = 1`: the Gaussian-built uniform measure
  is concentrated on the unit sphere.

Everything is intended to be `sorry`-free and axiom-clean.
-/

open MeasureTheory ProbabilityTheory
open BookProof.ChapterFreeFieldGaussian BookProof.ChapterFreeFieldSphere

namespace BookProof.ChapterFreeFieldSphereSupport

variable {n : ℕ}

/-
Radial normalization sends every nonzero vector to the unit sphere.
-/
theorem normalize_mem_sphere {x : EuclideanSpace ℝ (Fin n)} (hx : x ≠ 0) :
    normalize x ∈ Metric.sphere (0 : EuclideanSpace ℝ (Fin n)) 1 := by
  simp [ ChapterFreeFieldSphere.normalize, norm_smul, hx ]

/-
For `n ≥ 1` the standard Gaussian prior is atomless: every singleton is
null.  (For `n = 0` the space is a single point of full mass, so the hypothesis
`0 < n` is necessary.)
-/
theorem stdGaussian_singleton (hn : 0 < n) (x : EuclideanSpace ℝ (Fin n)) :
    stdGaussian n {x} = 0 := by
  rw [ stdGaussian, Measure.map_apply ];
  · rw [ show ( WithLp.toLp 2 ⁻¹' { x } : Set ( Fin n → ℝ ) ) = { fun i => x i } from ?_ ];
    · convert MeasureTheory.Measure.pi_pi _ _;
      rotate_right;
      focus (exact fun i => { x.ofLp i });
      · aesop;
      · simp only [gaussianReal, one_ne_zero, ↓reduceIte, measure_singleton, Finset.prod_const,
          Finset.card_univ, Fintype.card_fin];
        rw [ zero_pow hn.ne' ];
      · exact fun _ => inferInstance;
    · aesop;
  · fun_prop;
  · exact MeasurableSingletonClass.measurableSet_singleton _

/-
**Headline.** For `n ≥ 1` the Gaussian-built "uniform measure on the sphere"
is genuinely concentrated on the unit sphere: it assigns the full mass `1` to
`Metric.sphere 0 1`.
-/
theorem sphereGaussian_sphere_eq_one (hn : 0 < n) :
    sphereGaussian n (Metric.sphere (0 : EuclideanSpace ℝ (Fin n)) 1) = 1 := by
  rw [ sphereGaussian, Measure.map_apply ];
  · rw [ show ChapterFreeFieldSphere.normalize ⁻¹' Metric.sphere 0 1 = { 0 } ᶜ from ?_ ];
    · convert MeasureTheory.measure_compl _ _ <;> norm_num [ stdGaussian_singleton hn ];
    · ext x; simp [ChapterFreeFieldSphere.normalize];
      by_cases hx : x = 0 <;> simp [ hx, norm_smul ];
  · exact ChapterFreeFieldSphere.measurable_normalize
  · exact Metric.isClosed_sphere.measurableSet

end BookProof.ChapterFreeFieldSphereSupport
