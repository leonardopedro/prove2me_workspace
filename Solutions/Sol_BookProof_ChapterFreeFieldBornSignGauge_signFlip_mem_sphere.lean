-- Generated from ChapterFreeFieldBornSignGauge.lean — solution of BookProof.ChapterFreeFieldBornSignGauge.signFlip_mem_sphere
import Mathlib
import Definitions.Def_ChapterFreeFieldBornSignGauge
import Theorems.Thm_BookProof_ChapterFreeFieldBornSignGauge_signFlip_norm
open BookProof.ChapterFreeFieldBornSignGauge



open MeasureTheory
open BookProof.ChapterFreeFieldBorn


variable {n : ℕ}

variable {n : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution {s : Fin n → ℝ} (hs : ∀ k, s k = 1 ∨ s k = -1)
    {x : EuclideanSpace ℝ (Fin n)}
    (hx : x ∈ Metric.sphere (0 : EuclideanSpace ℝ (Fin n)) 1) :
    signFlip s x ∈ Metric.sphere (0 : EuclideanSpace ℝ (Fin n)) 1 := by

  rw [Metric.mem_sphere, dist_zero_right, signFlip_norm hs]
  rw [Metric.mem_sphere, dist_zero_right] at hx
  exact hx
