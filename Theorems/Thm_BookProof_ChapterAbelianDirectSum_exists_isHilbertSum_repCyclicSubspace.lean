-- Generated from ChapterAbelianDirectSum.lean — theorem BookProof.ChapterAbelianDirectSum.exists_isHilbertSum_repCyclicSubspace
import Definitions.Def_ChapterAbelianGelfandModel
import Definitions.Def_ChapterAbelianCyclicModel
import Mathlib
import Definitions.Def_ChapterAbelianDirectSum
open BookProof.ChapterAbelianDirectSum


noncomputable section

open MeasureTheory Complex WeakDual


open BookProof.ChapterAbelianGelfandModel BookProof.ChapterAbelianCyclicModel

variable {X : Type*} [TopologicalSpace X] [CompactSpace X] [T2Space X]
  [MeasurableSpace X] [BorelSpace X]
variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]
variable (pi : C(X, ℂ) →⋆ₐ[ℂ] (H →L[ℂ] H))


theorem BookProof.ChapterAbelianDirectSum.exists_isHilbertSum_repCyclicSubspace :
    ∃ S : Set H, OrthogonalRepCyclicFamily pi S ∧
      IsHilbertSum ℂ (fun x : S => (repCyclicSubspace pi (x : H)))
        (fun x : S => (repCyclicSubspace pi (x : H)).subtypeₗᵢ) := by sorry
