-- Generated from ChapterFreeFieldBornCont.lean — solution of BookProof.ChapterFreeFieldBornCont.continuous_bornMap
import Mathlib
import Definitions.Def_ChapterFreeFieldBornCont
open BookProof.ChapterFreeFieldBornCont



open MeasureTheory
open BookProof.ChapterFreeFieldBorn BookProof.ChapterFreeFieldBornSurj


variable {n : ℕ}

variable {n : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution :
    Continuous (bornMap : EuclideanSpace ℝ (Fin n) → (Fin n → ℝ)) := by

  unfold bornMap; fun_prop
