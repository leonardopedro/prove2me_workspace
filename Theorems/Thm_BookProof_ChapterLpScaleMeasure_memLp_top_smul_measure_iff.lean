-- Generated from ChapterLpScaleMeasure.lean — theorem BookProof.ChapterLpScaleMeasure.memLp_top_smul_measure_iff
import Definitions.Def_ChapterLinftyMultiplication
import Mathlib
import Definitions.Def_ChapterLpScaleMeasure
open BookProof.ChapterLpScaleMeasure

variable {α : Type*} [MeasurableSpace α] {nu : Measure α} {c : ENNReal}


noncomputable section

open MeasureTheory ENNReal


open BookProof.ChapterLinftyMultiplication


theorem BookProof.ChapterLpScaleMeasure.memLp_top_smul_measure_iff (hc0 : c ≠ 0) {f : α → ℂ} :
    MemLp f ⊤ (c • nu) ↔ MemLp f ⊤ nu := by sorry
