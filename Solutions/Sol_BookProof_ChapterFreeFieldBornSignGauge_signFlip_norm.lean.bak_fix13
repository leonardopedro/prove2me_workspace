-- Generated from ChapterFreeFieldBornSignGauge.lean — solution of BookProof.ChapterFreeFieldBornSignGauge.signFlip_norm
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
    ‖signFlip s x‖ = ‖x‖ := by

  rw [EuclideanSpace.norm_eq, EuclideanSpace.norm_eq]
  congr 1
  refine Finset.sum_congr rfl (fun k _ => ?_)
  rw [signFlip_apply]
  rcases hs k with h | h <;> rw [h] <;> simp [norm_neg]
