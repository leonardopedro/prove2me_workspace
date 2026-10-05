-- Generated from ChapterFreeFieldBornCont.lean — solution of BookProof.ChapterFreeFieldBornCont.continuous_bornSection
import Mathlib
import Definitions.Def_ChapterFreeFieldBornCont
open BookProof.ChapterFreeFieldBornCont



open MeasureTheory
open BookProof.ChapterFreeFieldBorn BookProof.ChapterFreeFieldBornSurj


variable {n : ℕ}

variable {n : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution :
    Continuous (bornSection : (Fin n → ℝ) → EuclideanSpace ℝ (Fin n)) := by

  unfold bornSection; fun_prop
