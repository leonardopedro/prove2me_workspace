-- Generated from ChapterHalfLineLimitCircle.lean — solution of BookProof.HalfLineLimitCircle.hlBumpTest_ne_zero
import Mathlib
import Definitions.Def_ChapterHalfLineLimitCircle
import Theorems.Thm_BookProof_HalfLineLimitCircle_hlBumpFun_two
open BookProof.HalfLineLimitCircle




open MeasureTheory Set BookProof.FarisLavine

noncomputable section

local notation "smoothTop" => ((⊤ : ℕ∞) : WithTop ℕ∞)

set_option maxHeartbeats 1000000 in
theorem solution : hlBumpTest ≠ 0 := by

  intro h
  have : hlBumpFun 2 = 0 := by
    have := congrArg (fun g : testSpace => (g : ℝ → ℂ) 2) h
    simpa [hlBumpTest] using this
  rw [hlBumpFun_two] at this
  exact one_ne_zero this
