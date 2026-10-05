-- Generated from ChapterAbelianDirectSum.lean — solution of BookProof.ChapterAbelianDirectSum.abelian_algebra_multiplication_model_general
import Mathlib
import Definitions.Def_ChapterAbelianDirectSum
import Theorems.Thm_BookProof_ChapterAbelianDirectSum_abelian_multiplication_model_general
open BookProof.ChapterAbelianDirectSum



noncomputable section

open MeasureTheory Complex WeakDual


open BookProof.ChapterAbelianGelfandModel BookProof.ChapterAbelianCyclicModel

variable {X : Type*} [TopologicalSpace X] [CompactSpace X] [T2Space X]
  [MeasurableSpace X] [BorelSpace X]
variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]
variable (pi : C(X, ℂ) →⋆ₐ[ℂ] (H →L[ℂ] H))

variable {X : Type*} [TopologicalSpace X] [CompactSpace X] [T2Space X]
  [MeasurableSpace X] [BorelSpace X]
variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]
variable (pi : C(X, ℂ) →⋆ₐ[ℂ] (H →L[ℂ] H))
variable (xi : H)
variable {pi}
variable (pi)
variable {A : Type*} [CommCStarAlgebra A]

set_option maxHeartbeats 1000000 in
theorem solution (rho : A →⋆ₐ[ℂ] (H →L[ℂ] H)) :
    ∃ (S : Set H) (mu : S → Measure (characterSpace ℂ A))
      (V : ∀ x : S, Lp ℂ 2 (mu x) →ₗᵢ[ℂ] H),
      (∀ x : S, IsProbabilityMeasure (mu x)) ∧
      IsHilbertSum ℂ (fun x : S => Lp ℂ 2 (mu x)) V ∧
      (∀ (x : S) (a : A) (u : Lp ℂ 2 (mu x)),
        V x (mulRep (mu x) (gelfandModel A a) u) = rho a (V x u)) := by

  obtain ⟨S, mu, V, hprob, hsum, hint⟩ :=
    abelian_multiplication_model_general (gelfandRep rho)
  refine ⟨S, mu, V, hprob, hsum, fun x a u => ?_⟩
  rw [hint x (gelfandModel A a) u, gelfandRep_gelfandModel]
