-- Generated from ChapterFreeFieldBornSignHom.lean — solution of BookProof.ChapterFreeFieldBornSignHom.flipVec_injective
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
theorem solution : Function.Injective (flipVec : (Fin n → Bool) → (Fin n → ℝ)) := by

  intro b₁ b₂ h; ext k; replace h := congr_fun h k; simp_all [flipVec]
  grind
