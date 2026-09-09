import Mathlib
import BookProof.ChapterFreeFieldGaussian

/-!
# Chapter "Wave-function parametrization of a probability measure", §5 —
# the uniform measure on the sphere from the Gaussian is rotation-invariant

Source: `book.tex`, chapter *"Wave-function parametrization of a probability
measure"*, section *"5. Free field parametrization in Bayesian inference and
Statistical Mechanics"* (`book.tex` line ~1706):

> "it is well known since many decades that a uniform (Lebesgue-like) measure of
> an infinite-dimensional sphere can be defined using the Gaussian measure and
> the Fock-space."

`ChapterFreeFieldGaussian` proved the finite-dimensional heart of §5 — the
standard Gaussian prior on `EuclideanSpace ℝ (Fin n)` is invariant under every
orthogonal transformation.  This file takes the explicit **next step**: the
Gaussian is pushed to the unit sphere by radial normalization
`x ↦ ‖x‖⁻¹ • x`, and the resulting measure — the book's *uniform measure on the
sphere built from the Gaussian* — is itself rotation-invariant.  This is exactly
because radial normalization commutes with orthogonal maps (which preserve the
norm), so the invariance of the Gaussian transports to the sphere measure.

## Main results

* `sphereGaussian` — the pushforward of `stdGaussian n` under radial
  normalization; the "uniform measure on the sphere" built from the Gaussian.
* `instance : IsProbabilityMeasure (sphereGaussian n)`.
* **headline** `sphereGaussian_map_linearIsometryEquiv` — for every orthogonal
  map `L`, `(sphereGaussian n).map L = sphereGaussian n`.

Everything is intended to be `sorry`-free and axiom-clean.
-/

open MeasureTheory
open BookProof.ChapterFreeFieldGaussian

namespace BookProof.ChapterFreeFieldSphere

variable {n : ℕ}

/-- Radial normalization `x ↦ ‖x‖⁻¹ • x` on `EuclideanSpace ℝ (Fin n)` (sending
`0 ↦ 0`).  It is measurable and commutes with every orthogonal map. -/
noncomputable def normalize (x : EuclideanSpace ℝ (Fin n)) : EuclideanSpace ℝ (Fin n) :=
  ‖x‖⁻¹ • x

theorem measurable_normalize : Measurable (normalize : EuclideanSpace ℝ (Fin n) → _) := by
  exact Measurable.smul ( measurable_norm.inv ) measurable_id'

/-
Radial normalization commutes with every orthogonal transformation, because
orthogonal maps preserve the norm.
-/
theorem normalize_comm (L : EuclideanSpace ℝ (Fin n) ≃ₗᵢ[ℝ] EuclideanSpace ℝ (Fin n))
    (x : EuclideanSpace ℝ (Fin n)) : normalize (L x) = L (normalize x) := by
  simp [ normalize, L.norm_map ]

/-- The **uniform measure on the sphere** built from the Gaussian: the
pushforward of the standard Gaussian prior under radial normalization. -/
noncomputable def sphereGaussian (n : ℕ) : Measure (EuclideanSpace ℝ (Fin n)) :=
  (stdGaussian n).map normalize

instance instIsProbabilityMeasure_sphereGaussian (n : ℕ) :
    IsProbabilityMeasure (sphereGaussian n) := by
  constructor;
  unfold sphereGaussian;
  rw [ Measure.map_apply ] <;> norm_num [ measurable_normalize ]

/-
**Headline.** The uniform sphere measure built from the Gaussian is
rotation-invariant: for every orthogonal map `L`,
`(sphereGaussian n).map L = sphereGaussian n`.
-/
theorem sphereGaussian_map_linearIsometryEquiv
    (L : EuclideanSpace ℝ (Fin n) ≃ₗᵢ[ℝ] EuclideanSpace ℝ (Fin n)) :
    (sphereGaussian n).map L = sphereGaussian n := by
  -- By definition of `sphereGaussian`, we have `(sphereGaussian n).map L = ((stdGaussian n).map
  -- normalize).map L`.
  rw [show sphereGaussian n = (stdGaussian n).map normalize from rfl];
  rw [ MeasureTheory.Measure.map_map, show L ∘ normalize = normalize ∘ L from ?_ ];
  · rw [ ← MeasureTheory.Measure.map_map, stdGaussian_map_linearIsometryEquiv ];
    · exact measurable_normalize;
    · exact L.continuous.measurable;
  · funext x; exact (normalize_comm L x).symm
  · exact L.continuous.measurable;
  · exact measurable_normalize

end BookProof.ChapterFreeFieldSphere
