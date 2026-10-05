-- Generated from ChapterHalfLineLimitCircle.lean — solution of BookProof.HalfLineLimitCircle.lam_sq
import Mathlib
import Definitions.Def_ChapterHalfLineLimitCircle
open BookProof.HalfLineLimitCircle




open MeasureTheory Set BookProof.FarisLavine

noncomputable section

local notation "smoothTop" => ((⊤ : ℕ∞) : WithTop ℕ∞)

set_option maxHeartbeats 1000000 in
theorem solution : lam ^ 2 = -Complex.I := by

  have h : ((Real.sqrt 2 / 2 : ℝ) : ℂ) ^ 2 = 1 / 2 := by
    norm_cast
    rw [div_pow, Real.sq_sqrt (by norm_num : (0:ℝ) ≤ 2)]
    norm_num
  have h2 : (1 - Complex.I) ^ 2 = -2 * Complex.I := by
    ring_nf; rw [Complex.I_sq]; ring
  rw [lam, mul_pow, h, h2]; ring
