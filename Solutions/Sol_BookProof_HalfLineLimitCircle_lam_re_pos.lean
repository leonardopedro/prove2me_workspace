-- Generated from ChapterHalfLineLimitCircle.lean — solution of BookProof.HalfLineLimitCircle.lam_re_pos
import Mathlib
import Definitions.Def_ChapterHalfLineLimitCircle
import Theorems.Thm_BookProof_HalfLineLimitCircle_lam_re
open BookProof.HalfLineLimitCircle




open MeasureTheory Set BookProof.FarisLavine

noncomputable section

local notation "smoothTop" => ((⊤ : ℕ∞) : WithTop ℕ∞)

set_option maxHeartbeats 1000000 in
theorem solution : 0 < lam.re := by

  rw [lam_re]
  positivity
