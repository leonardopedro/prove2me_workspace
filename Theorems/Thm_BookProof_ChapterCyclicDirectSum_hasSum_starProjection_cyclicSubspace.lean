-- Generated from ChapterCyclicDirectSum.lean — theorem BookProof.ChapterCyclicDirectSum.hasSum_starProjection_cyclicSubspace
import Definitions.Def_ChapterCyclicDecomposition
import Mathlib
import Definitions.Def_ChapterCyclicDirectSum
open BookProof.ChapterCyclicDirectSum


noncomputable section

open MeasureTheory Complex


open BookProof.ChapterCyclicDecomposition

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]
variable (T : H →L[ℂ] H) (hT : IsStarNormal T)


theorem BookProof.ChapterCyclicDirectSum.hasSum_starProjection_cyclicSubspace {S : Set H} (hS : OrthogonalCyclicFamily T hT S)
    (htop : (⨆ x ∈ S, cyclicSubspace T hT x).topologicalClosure = ⊤) (v : H) :
    HasSum (fun x : S => (cyclicSubspace T hT (x : H)).starProjection v) v := by sorry
