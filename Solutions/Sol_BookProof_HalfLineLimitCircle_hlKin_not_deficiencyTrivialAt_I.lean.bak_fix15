-- Generated from ChapterHalfLineLimitCircle.lean — solution of BookProof.HalfLineLimitCircle.hlKin_not_deficiencyTrivialAt_I
import Mathlib
import Definitions.Def_ChapterHalfLineLimitCircle
import Theorems.Thm_BookProof_HalfLineLimitCircle_deficiencyVec_ne_zero
import Theorems.Thm_BookProof_HalfLineLimitCircle_hlKin_deficiency_identity
open BookProof.HalfLineLimitCircle




open MeasureTheory Set BookProof.FarisLavine

noncomputable section

local notation "smoothTop" => ((⊤ : ℕ∞) : WithTop ℕ∞)

set_option maxHeartbeats 1000000 in
theorem solution : ¬ DeficiencyTrivialAt hlCore hlKin Complex.I := by

  intro h
  exact deficiencyVec_ne_zero (h deficiencyVec hlKin_deficiency_identity)
