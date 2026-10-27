-- Generated from ChapterAbelianCyclicModel.lean — solution of BookProof.ChapterAbelianCyclicModel.abelian_algebra_multiplication_model
import Mathlib
import Definitions.Def_ChapterAbelianCyclicModel
import Theorems.Thm_BookProof_ChapterAbelianCyclicModel_cyclic_representation_multiplication_model
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
variable {A : Type*} [CommCStarAlgebra A]

set_option maxHeartbeats 1000000 in
theorem solution (rho : A →⋆ₐ[ℂ] (H →L[ℂ] H)) (xi : H)
    (hxi : ‖xi‖ = 1) (hcyc : DenseRange fun a : A => rho a xi) :
    ∃ (mu : Measure (characterSpace ℂ A)) (_ : IsProbabilityMeasure mu)
      (U : Lp ℂ 2 mu ≃ₗᵢ[ℂ] H),
      ∀ (a : A) (u : Lp ℂ 2 mu), U (mulRep mu (gelfandModel A a) u) = rho a (U u) := by

  have hrange : Set.range (repVec (gelfandRep rho) xi) = Set.range fun a : A => rho a xi := by
    ext v
    constructor
    · rintro ⟨f, rfl⟩
      exact ⟨(gelfandModel A).symm f, rfl⟩
    · rintro ⟨a, rfl⟩
      exact ⟨gelfandModel A a, by simp [repVec]⟩
  have hcyc' : DenseRange (repVec (gelfandRep rho) xi) := by
    rw [DenseRange, hrange]
    exact hcyc
  obtain ⟨mu, hmu, U, hU, -⟩ :=
    cyclic_representation_multiplication_model (gelfandRep rho) xi hcyc' hxi
  refine ⟨mu, hmu, U, fun a u => ?_⟩
  rw [hU (gelfandModel A a) u, gelfandRep_gelfandModel]
