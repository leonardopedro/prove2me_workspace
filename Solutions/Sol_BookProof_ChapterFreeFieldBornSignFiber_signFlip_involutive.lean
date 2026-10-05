-- Generated from ChapterFreeFieldBornSignFiber.lean — solution of BookProof.ChapterFreeFieldBornSignFiber.signFlip_involutive
import Mathlib
import Definitions.Def_ChapterFreeFieldBornSignFiber
open BookProof.ChapterFreeFieldBornSignFiber



open MeasureTheory
open BookProof.ChapterFreeFieldBorn BookProof.ChapterFreeFieldBornSignGauge


variable {n : ℕ}

variable {n : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution {s : Fin n → ℝ} (hs : ∀ k, s k = 1 ∨ s k = -1)
    (x : EuclideanSpace ℝ (Fin n)) :
    signFlip s (signFlip s x) = x := by

  ext k; cases hs k <;> simp [*]
