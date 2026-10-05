-- Generated from ChapterSeparableSpectrum.lean — solution of BookProof.ChapterSeparableSpectrum.abelian_multiplication_model_classified_separable
import Mathlib
import Definitions.Def_ChapterSeparableSpectrum
import Theorems.Thm_BookProof_ChapterSeparableSpectrum_metrizableSpace_of_separable_continuousMap
import Theorems.Thm_BookProof_ChapterStandardBorelClassification_abelian_multiplication_model_classified
open BookProof.ChapterSeparableSpectrum



noncomputable section

open MeasureTheory TopologicalSpace WeakDual


open BookProof.ChapterAbelianGelfandModel BookProof.ChapterAbelianDirectSum
open BookProof.ChapterStandardBorelClassification

variable (Y : Type*) [TopologicalSpace Y] [CompactSpace Y] [T2Space Y]
variable {Y : Type*} [TopologicalSpace Y] [CompactSpace Y] [T2Space Y]
  [SeparableSpace C(Y, ℂ)] [MeasurableSpace Y] [BorelSpace Y]
variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]

set_option maxHeartbeats 1000000 in
theorem solution (pi : C(Y, ℂ) →⋆ₐ[ℂ] (H →L[ℂ] H)) :
    ∃ (S : Set H) (mu : S → Measure Y) (V : ∀ x : S, Lp ℂ 2 (mu x) →ₗᵢ[ℂ] H),
      (∀ x : S, IsProbabilityMeasure (mu x)) ∧
      IsHilbertSum ℂ (fun x : S => Lp ℂ 2 (mu x)) V ∧
      (∀ (x : S) (g : C(Y, ℂ)) (u : Lp ℂ 2 (mu x)),
        V x (mulRep (mu x) g u) = pi g (V x u)) ∧
      (∀ x : S, ∃ _ : IsProbabilityMeasure (mu x), RealizesStandardType (mu x)) := by

  haveI : MetrizableSpace Y := metrizableSpace_of_separable_continuousMap Y
  exact abelian_multiplication_model_classified pi
