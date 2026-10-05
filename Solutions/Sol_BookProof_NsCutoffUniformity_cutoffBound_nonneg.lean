-- Generated from ChapterNsCutoffUniformity.lean — solution of BookProof.NsCutoffUniformity.cutoffBound_nonneg
import Mathlib
import Definitions.Def_ChapterNsCutoffUniformity
open BookProof.NsCutoffUniformity




open MvPolynomial BookProof.NsFullEuler

noncomputable section

variable {n : ℕ}

variable {n : ℕ}
variable {ι : Type*}

set_option maxHeartbeats 1000000 in
theorem solution (nu : ℝ) {Λ : ℝ} (hΛ : 0 ≤ Λ) : 0 ≤ cutoffBound nu Λ := by

  unfold cutoffBound
  positivity
