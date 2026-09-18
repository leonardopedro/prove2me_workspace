-- Generated from ChapterH6.lean — solution of BookProof.ChapterH6.sirk_error_tendsto_zero
import Mathlib
import Definitions.Def_ChapterH6
import Theorems.Thm_BookProof_ChapterH6_sirk_error_decay_exponential
open BookProof.ChapterH6



noncomputable section

open Filter Topology

set_option maxHeartbeats 1000000 in
theorem solution (C Dmin h nv : ℝ) (hh : 0 < h) {ε : ℝ} (hε : 0 < ε) :
    ∀ᶠ m : ℕ in atTop, |sirkBound C Dmin h nv m| < ε := by

  have h0 := sirk_error_decay_exponential C Dmin h nv hh
  have := h0 (Metric.ball_mem_nhds (0 : ℝ) hε)
  simpa [Real.dist_eq, Metric.mem_ball] using this
