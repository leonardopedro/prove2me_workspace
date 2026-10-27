-- Generated from ChapterHalfLineLimitCircle.lean — solution of BookProof.HalfLineLimitCircle.hlBumpFun_two
import Mathlib
import Definitions.Def_ChapterHalfLineLimitCircle
open BookProof.HalfLineLimitCircle




open MeasureTheory Set BookProof.FarisLavine

noncomputable section

local notation "smoothTop" => ((⊤ : ℕ∞) : WithTop ℕ∞)

set_option maxHeartbeats 1000000 in
theorem solution : hlBumpFun 2 = 1 := by

  have h : hlBump 2 = 1 :=
    hlBump.one_of_mem_closedBall (by simp [Metric.mem_closedBall]; norm_num [hlBump])
  simp [hlBumpFun, h]
