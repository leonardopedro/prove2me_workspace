-- Generated from ChapterCyclicDirectSum.lean — theorem BookProof.ChapterCyclicDirectSum.hasSum_starProjection_cyclicSubspace
import Mathlib
import Definitions.Def_ChapterCyclicDirectSum
import Definitions.Def_ChapterA4
open BookProof.ChapterCyclicDirectSum

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]
variable (T : H →L[ℂ] H) (hT : IsStarNormal T)


noncomputable section

open MeasureTheory Complex


open BookProof.ChapterCyclicDecomposition


theorem BookProof.ChapterCyclicDirectSum.hasSum_starProjection_cyclicSubspace {S : Set H} (hS : OrthogonalCyclicFamily T hT S)
    (htop : (⨆ x ∈ S, cyclicSubspace T hT x).topologicalClosure = ⊤) (v : H) :
    HasSum (fun x : S => (cyclicSubspace T hT (x : H)).starProjection v) v := by sorry
