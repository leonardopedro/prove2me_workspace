import Mathlib
import BookProof.ChapterSolovayCoordinates

/-!
# Cross-dimensional embedding of the coordinate Solovay–Kopperman substrate

`BookProof.ChapterSolovayCoordinates` realizes a state of the substrate as a pair
`(head, tail)` with `head : Fin N → ℝ` distributed according to an arbitrary
probability law and `tail : ℕ → ℝ` distributed according to the Mehler
(countable product Gaussian) law, and it provides the coordinate splitting
`enlargeEquiv N k` which moves `k` Gaussian coordinates out of the tail and
appends them to the head.

This file records the two structural consequences used by the book:

* `cross_dim_embedding` — the enlargement `N ↦ N + k` is a *measure-preserving*
  isomorphism of the corresponding state spaces (it is a genuine embedding of the
  `N`-dimensional model into the `(N+k)`-dimensional model, not merely a
  measurable bijection);
* `integral_cross_dim_well_defined` / `inner_cross_dim_well_defined` — every
  expectation, and in particular the `L²` inner product of two wave functions,
  is unchanged when it is computed after enlarging the head dimension.  This is
  the book's claim that "the inner product is well defined across head
  dimensions": the value does not depend on the dimension `M = N + k` in which
  the computation is performed.

Everything is `sorry`-free and `axiom`-free (only `propext`, `Classical.choice`,
`Quot.sound`).
-/

open MeasureTheory ProbabilityTheory

noncomputable section

namespace BookProof.ChapterSolovayCrossDim

open BookProof.ChapterSolovayCoordinates

/-- **Cross-dimensional embedding.**  Splitting `k` Gaussian coordinates off the
tail and appending them to the head is a measure-preserving isomorphism from the
`N`-dimensional coordinate state space onto the `(N+k)`-dimensional one. -/
theorem cross_dim_embedding (N k : ℕ) (headDist : Measure (Fin N → ℝ))
    [IsProbabilityMeasure headDist] :
    MeasurePreserving (enlargeEquiv N k) (coordinateStateMeasure N headDist)
      (coordinateStateMeasure (N + k) (enlargedHeadMeasure N k headDist)) :=
  ⟨(enlargeEquiv N k).measurable, enlargeEquiv_map N k headDist⟩

/-- Expectations are independent of the head dimension in which they are
computed: for any observable `F` on the enlarged space, its expectation in the
`(N+k)`-dimensional model equals the expectation of its pullback in the
`N`-dimensional model. -/
theorem integral_cross_dim_well_defined (N k : ℕ) (headDist : Measure (Fin N → ℝ))
    [IsProbabilityMeasure headDist] (F : CoordinateSpace (N + k) → ℂ) :
    ∫ x, F (enlargeEquiv N k x) ∂(coordinateStateMeasure N headDist) =
      ∫ y, F y ∂(coordinateStateMeasure (N + k) (enlargedHeadMeasure N k headDist)) :=
  (cross_dim_embedding N k headDist).integral_comp' F

/-- **The inner product is well defined across head dimensions.**  The `L²`
pairing of two wave functions computed in the enlarged model coincides with the
pairing of their pullbacks computed in the original model, so the value assigned
to a pair of states does not depend on the dimension used to represent them. -/
theorem inner_cross_dim_well_defined (N k : ℕ) (headDist : Measure (Fin N → ℝ))
    [IsProbabilityMeasure headDist] (Psi1 Psi2 : CoordinateSpace (N + k) → ℂ) :
    ∫ x, star (Psi1 (enlargeEquiv N k x)) * Psi2 (enlargeEquiv N k x)
        ∂(coordinateStateMeasure N headDist) =
      ∫ y, star (Psi1 y) * Psi2 y
        ∂(coordinateStateMeasure (N + k) (enlargedHeadMeasure N k headDist)) :=
  integral_cross_dim_well_defined N k headDist (fun y => star (Psi1 y) * Psi2 y)

/-- The `ℝ≥0∞`-valued (unsigned) form of the same invariance, valid for every
measurable observable without any integrability assumption. -/
theorem lintegral_cross_dim_well_defined (N k : ℕ) (headDist : Measure (Fin N → ℝ))
    [IsProbabilityMeasure headDist] (F : CoordinateSpace (N + k) → ENNReal) :
    ∫⁻ x, F (enlargeEquiv N k x) ∂(coordinateStateMeasure N headDist) =
      ∫⁻ y, F y ∂(coordinateStateMeasure (N + k) (enlargedHeadMeasure N k headDist)) :=
  (MeasurePreserving.lintegral_map_equiv F (enlargeEquiv N k)
    (cross_dim_embedding N k headDist)).symm

/-- Enlarging the head does not change the total mass: the enlarged state law is
again a probability law. -/
theorem cross_dim_isProbability (N k : ℕ) (headDist : Measure (Fin N → ℝ))
    [IsProbabilityMeasure headDist] :
    IsProbabilityMeasure
      (coordinateStateMeasure (N + k) (enlargedHeadMeasure N k headDist)) :=
  inferInstance

end BookProof.ChapterSolovayCrossDim
