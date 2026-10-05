-- Generated from ChapterAbelianDirectSum.lean — theorem BookProof.ChapterAbelianDirectSum.abelian_algebra_multiplication_model_general
import Definitions.Def_ChapterAbelianGelfandModel
import Definitions.Def_ChapterAbelianCyclicModel
import Mathlib
import Definitions.Def_ChapterAbelianDirectSum
open BookProof.ChapterAbelianDirectSum

variable {X : Type*} [TopologicalSpace X] [CompactSpace X] [T2Space X]
  [MeasurableSpace X] [BorelSpace X]
variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]
variable (pi : C(X, ℂ) →⋆ₐ[ℂ] (H →L[ℂ] H))
variable (xi : H)
variable {pi}
variable (pi)
variable {A : Type*} [CommCStarAlgebra A]


noncomputable section

open MeasureTheory Complex WeakDual


open BookProof.ChapterAbelianGelfandModel BookProof.ChapterAbelianCyclicModel


theorem BookProof.ChapterAbelianDirectSum.abelian_algebra_multiplication_model_general (rho : A →⋆ₐ[ℂ] (H →L[ℂ] H)) :
    ∃ (S : Set H) (mu : S → Measure (characterSpace ℂ A))
      (V : ∀ x : S, Lp ℂ 2 (mu x) →ₗᵢ[ℂ] H),
      (∀ x : S, IsProbabilityMeasure (mu x)) ∧
      IsHilbertSum ℂ (fun x : S => Lp ℂ 2 (mu x)) V ∧
      (∀ (x : S) (a : A) (u : Lp ℂ 2 (mu x)),
        V x (mulRep (mu x) (gelfandModel A a) u) = rho a (V x u)) := by sorry
