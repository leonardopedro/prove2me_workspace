-- Generated from ChapterAbelianDirectSum.lean — theorem BookProof.ChapterAbelianDirectSum.orthogonalFamily_repEmbedding
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


noncomputable section

open MeasureTheory Complex WeakDual


open BookProof.ChapterAbelianGelfandModel BookProof.ChapterAbelianCyclicModel


theorem BookProof.ChapterAbelianDirectSum.orthogonalFamily_repEmbedding {S : Set H} (hS : OrthogonalRepCyclicFamily pi S) :
    OrthogonalFamily ℂ (fun x : S => Lp ℂ 2 (repMeasure pi (x : H)))
      (fun x : S => repEmbedding pi (x : H)) := by sorry
