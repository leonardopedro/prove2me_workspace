-- Generated from ChapterFreeFieldBornSurj.lean — theorem BookProof.ChapterFreeFieldBornSurj.bornSection_apply
import Mathlib
import Definitions.Def_ChapterFreeFieldBornSurj
import Definitions.Def_ChapterA4
open BookProof.ChapterFreeFieldBornSurj

variable {n : ℕ}


open MeasureTheory



theorem BookProof.ChapterFreeFieldBornSurj.bornSection_apply (p : Fin n → ℝ) (k : Fin n) :
    bornSection p k = Real.sqrt (p k) := by sorry
