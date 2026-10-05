-- Generated from ChapterFreeFieldBornSignHom.lean — solution of BookProof.ChapterFreeFieldBornSignHom.flipVec_mul_self
import Mathlib
import Definitions.Def_ChapterFreeFieldBornSignHom
open BookProof.ChapterFreeFieldBornSignHom



open MeasureTheory
open BookProof.ChapterFreeFieldBorn
open BookProof.ChapterFreeFieldBornSignGauge
open BookProof.ChapterFreeFieldBornSignAction


variable {n : ℕ}

variable {n : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (b : Fin n → Bool) :
    flipVec b * flipVec b = (1 : Fin n → ℝ) := by

  ext k; unfold flipVec; by_cases h : b k <;> simp [h]
