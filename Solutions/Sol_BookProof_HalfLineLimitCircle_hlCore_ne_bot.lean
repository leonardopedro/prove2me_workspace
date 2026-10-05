-- Generated from ChapterHalfLineLimitCircle.lean — solution of BookProof.HalfLineLimitCircle.hlCore_ne_bot
import Mathlib
import Definitions.Def_ChapterHalfLineLimitCircle
import Theorems.Thm_BookProof_HalfLineLimitCircle_hlBumpTest_ne_zero
open BookProof.HalfLineLimitCircle




open MeasureTheory Set BookProof.FarisLavine

noncomputable section

local notation "smoothTop" => ((⊤ : ℕ∞) : WithTop ℕ∞)

set_option maxHeartbeats 1000000 in
theorem solution : hlCore ≠ ⊥ := by

  intro h
  have hmem : testIncl hlBumpTest ∈ hlCore := ⟨hlBumpTest, rfl⟩
  rw [h, Submodule.mem_bot] at hmem
  exact hlBumpTest_ne_zero (testIncl_injective (by rw [hmem, map_zero]))
