-- Generated from ChapterLpScaleMeasure.lean — solution of BookProof.ChapterLpScaleMeasure.scaleUnitary_coeFn
import Mathlib
import Definitions.Def_ChapterLpScaleMeasure
open BookProof.ChapterLpScaleMeasure



noncomputable section

open MeasureTheory ENNReal


open BookProof.ChapterLinftyMultiplication

variable {α : Type*} [MeasurableSpace α] {nu : Measure α} {c : ENNReal}

variable {α : Type*} [MeasurableSpace α] {nu : Measure α} {c : ENNReal}

set_option maxHeartbeats 1000000 in
theorem solution (hc0 : c ≠ 0) (hctop : c ≠ ⊤) (u : Lp ℂ 2 (c • nu)) :
    (scaleUnitary hc0 hctop u : α → ℂ)
      =ᵐ[nu] fun x => (scaleConst c : ℂ) * (u : α → ℂ) x := scaleLin_coeFn hc0 hctop u
