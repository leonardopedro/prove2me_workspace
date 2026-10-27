-- Generated from ChapterAbelianCyclicModel.lean — solution of BookProof.ChapterAbelianCyclicModel.cyclic_representation_multiplication_model
import Mathlib
import Definitions.Def_ChapterAbelianCyclicModel
import Theorems.Thm_BookProof_ChapterAbelianCyclicModel_isProbabilityMeasure_repMeasure
import Theorems.Thm_BookProof_ChapterAbelianCyclicModel_cyclicRepUnitary_intertwines
open BookProof.ChapterAbelianCyclicModel



open MeasureTheory Complex WeakDual
open scoped ComplexOrder


open BookProof.ChapterAbelianGelfandModel


variable {X : Type*} [TopologicalSpace X] [CompactSpace X] [T2Space X]
  [MeasurableSpace X] [BorelSpace X]
variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]
variable (pi : C(X, ℂ) →⋆ₐ[ℂ] (H →L[ℂ] H)) (xi : H)

variable {X : Type*} [TopologicalSpace X] [CompactSpace X] [T2Space X]
  [MeasurableSpace X] [BorelSpace X]
variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]
variable (pi : C(X, ℂ) →⋆ₐ[ℂ] (H →L[ℂ] H)) (xi : H)
variable (hcyc : DenseRange (repVec pi xi))

set_option maxHeartbeats 1000000 in
theorem solution (hxi : ‖xi‖ = 1) :
    ∃ (mu : Measure X) (_ : IsProbabilityMeasure mu) (U : Lp ℂ 2 mu ≃ₗᵢ[ℂ] H),
      (∀ (g : C(X, ℂ)) (u : Lp ℂ 2 mu), U (mulRep mu g u) = pi g (U u)) ∧
      (∀ (g : C(X, ℂ)) (v : H), U.symm (pi g v) = mulRep mu g (U.symm v)) := by

  refine ⟨repMeasure pi xi, isProbabilityMeasure_repMeasure pi xi hxi,
    cyclicRepUnitary pi xi hcyc, cyclicRepUnitary_intertwines pi xi hcyc, ?_⟩
  intro g v
  have h := cyclicRepUnitary_intertwines pi xi hcyc g ((cyclicRepUnitary pi xi hcyc).symm v)
  rw [LinearIsometryEquiv.apply_symm_apply] at h
  rw [← h, LinearIsometryEquiv.symm_apply_apply]
