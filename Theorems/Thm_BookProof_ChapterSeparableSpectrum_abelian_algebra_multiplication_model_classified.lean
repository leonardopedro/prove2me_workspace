-- Generated from ChapterSeparableSpectrum.lean — theorem BookProof.ChapterSeparableSpectrum.abelian_algebra_multiplication_model_classified
import Definitions.Def_ChapterAbelianGelfandModel
import Definitions.Def_ChapterAbelianDirectSum
import Definitions.Def_ChapterStandardBorelClassification
import Mathlib
import Definitions.Def_ChapterSeparableSpectrum
open BookProof.ChapterSeparableSpectrum

variable (Y : Type*) [TopologicalSpace Y] [CompactSpace Y] [T2Space Y]
variable {Y : Type*} [TopologicalSpace Y] [CompactSpace Y] [T2Space Y]
  [SeparableSpace C(Y, ℂ)] [MeasurableSpace Y] [BorelSpace Y]
variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]
variable (A : Type*) [CommCStarAlgebra A]
variable {A}


noncomputable section

open MeasureTheory TopologicalSpace WeakDual


open BookProof.ChapterAbelianGelfandModel BookProof.ChapterAbelianDirectSum
open BookProof.ChapterStandardBorelClassification

theorem BookProof.ChapterSeparableSpectrum.abelian_algebra_multiplication_model_classified [SeparableSpace A]
    (rho : A →⋆ₐ[ℂ] (H →L[ℂ] H)) :
    ∃ (S : Set H) (mu : S → Measure (characterSpace ℂ A))
      (V : ∀ x : S, Lp ℂ 2 (mu x) →ₗᵢ[ℂ] H),
      (∀ x : S, IsProbabilityMeasure (mu x)) ∧
      IsHilbertSum ℂ (fun x : S => Lp ℂ 2 (mu x)) V ∧
      (∀ (x : S) (a : A) (u : Lp ℂ 2 (mu x)),
        V x (mulRep (mu x) (gelfandModel A a) u) = rho a (V x u)) ∧
      (∀ x : S, ∃ _ : IsProbabilityMeasure (mu x), RealizesStandardType (mu x)) := by sorry
