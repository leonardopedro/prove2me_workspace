-- Generated from ChapterLpScaleMeasure.lean — theorem BookProof.ChapterLpScaleMeasure.scaleUnitary_coeFn
import Definitions.Def_ChapterLinftyMultiplication
import Mathlib
import Definitions.Def_ChapterLpScaleMeasure
open BookProof.ChapterLpScaleMeasure


noncomputable section

open MeasureTheory ENNReal


open BookProof.ChapterLinftyMultiplication

variable {α : Type*} [MeasurableSpace α] {nu : Measure α} {c : ENNReal}


theorem BookProof.ChapterLpScaleMeasure.scaleUnitary_coeFn (hc0 : c ≠ 0) (hctop : c ≠ ⊤) (u : Lp ℂ 2 (c • nu)) :
    (scaleUnitary hc0 hctop u : α → ℂ)
      =ᵐ[nu] fun x => (scaleConst c : ℂ) * (u : α → ℂ) x := by sorry
