import Mathlib
import BookProof.ChapterFreeFieldSphereSupport

/-!
# Chapter "Wave-function parametrization of a probability measure", §5 —
# the Gaussian-built uniform sphere measure is a fixed point of re-normalization

Source: `book.tex`, chapter *"Wave-function parametrization of a probability
measure"*, section *"5. Free field parametrization in Bayesian inference and
Statistical Mechanics"* (`book.tex` line ~1706):

> "it is well known since many decades that a uniform (Lebesgue-like) measure of
> an infinite-dimensional sphere can be defined using the Gaussian measure and
> the Fock-space."

`ChapterFreeFieldSphere` defined `sphereGaussian`, the pushforward of the
standard Gaussian prior under radial normalization `x ↦ ‖x‖⁻¹ • x`, and
`ChapterFreeFieldSphereSupport` proved (for `n ≥ 1`) that the resulting measure
lives on the unit sphere.  This file records the natural companion fact that
makes precise "the construction produces a measure *on the sphere*": the sphere
measure is a **fixed point of the normalization pushforward**.  Since the
Gaussian assigns no mass to the origin, radial normalization is idempotent
almost everywhere, so pushing `sphereGaussian` forward again by `normalize`
returns `sphereGaussian` unchanged.

## Main results

* `normalize_normalize` — radial normalization is idempotent off the origin:
  for `x ≠ 0`, `normalize (normalize x) = normalize x`.
* **headline** `sphereGaussian_map_normalize` — for `n ≥ 1`,
  `(sphereGaussian n).map normalize = sphereGaussian n`: the Gaussian-built
  uniform sphere measure is a fixed point of re-normalization.

Everything is intended to be `sorry`-free and axiom-clean.
-/

open MeasureTheory
open BookProof.ChapterFreeFieldGaussian BookProof.ChapterFreeFieldSphere
open BookProof.ChapterFreeFieldSphereSupport

namespace BookProof.ChapterFreeFieldSphereFixpoint

variable {n : ℕ}

/-
Radial normalization is idempotent off the origin: normalizing an already
normalized (hence unit-norm) vector leaves it unchanged.
-/
theorem normalize_normalize {x : EuclideanSpace ℝ (Fin n)} (hx : x ≠ 0) :
    ChapterFreeFieldSphere.normalize (ChapterFreeFieldSphere.normalize x)
      = ChapterFreeFieldSphere.normalize x := by
  unfold ChapterFreeFieldSphere.normalize ;
  simp [ norm_smul, hx ]

/-
**Headline.** For `n ≥ 1` the Gaussian-built uniform sphere measure is a fixed
point of the normalization pushforward: pushing `sphereGaussian n` forward again
by radial normalization returns it unchanged.  This is because the standard
Gaussian is atomless at the origin (`stdGaussian_singleton`), so `normalize` is
idempotent almost everywhere (`normalize_normalize`).
-/
theorem sphereGaussian_map_normalize (hn : 0 < n) :
    (sphereGaussian n).map ChapterFreeFieldSphere.normalize = sphereGaussian n := by
  rw [show sphereGaussian n = (stdGaussian n).map ChapterFreeFieldSphere.normalize from rfl,
    MeasureTheory.Measure.map_map]
  · refine MeasureTheory.Measure.map_congr ?_
    filter_upwards [MeasureTheory.measure_eq_zero_iff_ae_notMem.mp (stdGaussian_singleton hn 0)]
      with x hx using normalize_normalize hx
  · exact measurable_normalize
  · exact measurable_normalize

end BookProof.ChapterFreeFieldSphereFixpoint
