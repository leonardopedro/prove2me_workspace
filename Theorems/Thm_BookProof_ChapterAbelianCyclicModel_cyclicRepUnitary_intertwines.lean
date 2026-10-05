-- Generated from ChapterAbelianCyclicModel.lean — theorem BookProof.ChapterAbelianCyclicModel.cyclicRepUnitary_intertwines
import Definitions.Def_ChapterAbelianGelfandModel
import Mathlib
import Definitions.Def_ChapterAbelianCyclicModel
open BookProof.ChapterAbelianCyclicModel

variable {X : Type*} [TopologicalSpace X] [CompactSpace X] [T2Space X]
  [MeasurableSpace X] [BorelSpace X]
variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]
variable (pi : C(X, ℂ) →⋆ₐ[ℂ] (H →L[ℂ] H)) (xi : H)
variable (hcyc : DenseRange (repVec pi xi))


open MeasureTheory Complex WeakDual
open scoped ComplexOrder


open BookProof.ChapterAbelianGelfandModel



theorem BookProof.ChapterAbelianCyclicModel.cyclicRepUnitary_intertwines (g : C(X, ℂ)) (u : Lp ℂ 2 (repMeasure pi xi)) :
    cyclicRepUnitary pi xi hcyc (mulRep (repMeasure pi xi) g u)
      = pi g (cyclicRepUnitary pi xi hcyc u) := by sorry
