-- Generated from ChapterFreeFieldBornSignHom.lean — solution of BookProof.ChapterFreeFieldBornSignHom.flipVec_false
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
theorem solution : flipVec (fun _ => false : Fin n → Bool) = (1 : Fin n → ℝ) := by

  ext k; simp [flipVec]
