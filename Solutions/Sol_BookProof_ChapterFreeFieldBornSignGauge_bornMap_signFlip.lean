-- Generated from ChapterFreeFieldBornSignGauge.lean — solution of BookProof.ChapterFreeFieldBornSignGauge.bornMap_signFlip
import Mathlib
import Definitions.Def_ChapterFreeFieldBornSignGauge
open BookProof.ChapterFreeFieldBornSignGauge



open MeasureTheory
open BookProof.ChapterFreeFieldBorn


variable {n : ℕ}

variable {n : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution {s : Fin n → ℝ} (hs : ∀ k, s k = 1 ∨ s k = -1)
    (x : EuclideanSpace ℝ (Fin n)) :
    bornMap (signFlip s x) = bornMap x := by

  funext k
  change (signFlip s x k) ^ 2 = (x k) ^ 2
  rw [signFlip_apply]
  rcases hs k with h | h <;> rw [h] <;> ring
