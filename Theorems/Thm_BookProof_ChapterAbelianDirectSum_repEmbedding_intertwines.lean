-- Generated from ChapterAbelianDirectSum.lean — theorem BookProof.ChapterAbelianDirectSum.repEmbedding_intertwines
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


noncomputable section

open MeasureTheory Complex WeakDual


open BookProof.ChapterAbelianGelfandModel BookProof.ChapterAbelianCyclicModel


theorem BookProof.ChapterAbelianDirectSum.repEmbedding_intertwines (g : C(X, ℂ)) (u : Lp ℂ 2 (repMeasure pi xi)) :
    repEmbedding pi xi (mulRep (repMeasure pi xi) g u) = pi g (repEmbedding pi xi u) := by sorry
