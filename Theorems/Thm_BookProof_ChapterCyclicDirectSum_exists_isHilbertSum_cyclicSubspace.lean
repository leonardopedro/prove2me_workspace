-- Generated from ChapterCyclicDirectSum.lean — theorem BookProof.ChapterCyclicDirectSum.exists_isHilbertSum_cyclicSubspace
import Mathlib
import Definitions.Def_ChapterCyclicDirectSum
import Definitions.Def_ChapterA4
open BookProof.ChapterCyclicDirectSum

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]
variable (T : H →L[ℂ] H) (hT : IsStarNormal T)


noncomputable section

open MeasureTheory Complex


open BookProof.ChapterCyclicDecomposition


theorem BookProof.ChapterCyclicDirectSum.exists_isHilbertSum_cyclicSubspace :
    ∃ S : Set H, OrthogonalCyclicFamily T hT S ∧
      IsHilbertSum ℂ (fun x : S => (cyclicSubspace T hT (x : H)))
        (fun x : S => (cyclicSubspace T hT (x : H)).subtypeₗᵢ) := by sorry
