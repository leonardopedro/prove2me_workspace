-- Generated from ChapterLpScaleMeasure.lean — theorem BookProof.ChapterLpScaleMeasure.scaleUnitary_intertwines
import Mathlib
import Definitions.Def_ChapterLpScaleMeasure
import Definitions.Def_ChapterLinftyMultiplication
open BookProof.ChapterLinftyMultiplication
open BookProof.ChapterLpScaleMeasure

variable {α : Type*} [MeasurableSpace α] {nu : Measure α} {c : ENNReal}


noncomputable section

open MeasureTheory ENNReal


open BookProof.ChapterLinftyMultiplication


theorem BookProof.ChapterLpScaleMeasure.scaleUnitary_intertwines (hc0 : c ≠ 0) (hctop : c ≠ ⊤) {g : α → ℂ}
    (hg : MemLp g ⊤ (c • nu)) (u : Lp ℂ 2 (c • nu)) :
    (scaleUnitary hc0 hctop (multOp g hg u) : α → ℂ)
      =ᵐ[nu] fun x => g x * (scaleUnitary (nu := nu) hc0 hctop u : α → ℂ) x := by sorry
