-- Generated from ChapterCyclicDirectSum.lean — theorem BookProof.ChapterCyclicDirectSum.exists_isHilbertSum_cyclicSubspace
import Definitions.Def_ChapterCyclicDecomposition
import Mathlib
import Definitions.Def_ChapterCyclicDirectSum
open BookProof.ChapterCyclicDirectSum


noncomputable section

open MeasureTheory Complex


open BookProof.ChapterCyclicDecomposition

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]
variable (T : H →L[ℂ] H) (hT : IsStarNormal T)


theorem BookProof.ChapterCyclicDirectSum.exists_isHilbertSum_cyclicSubspace :
    ∃ S : Set H, OrthogonalCyclicFamily T hT S ∧
      IsHilbertSum ℂ (fun x : S => (cyclicSubspace T hT (x : H)))
        (fun x : S => (cyclicSubspace T hT (x : H)).subtypeₗᵢ) := by sorry
