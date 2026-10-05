-- Generated from ChapterHalfLineLimitCircle.lean — solution of BookProof.HalfLineLimitCircle.hlKin_neg_not_essentiallySelfAdjointOn
import Mathlib
import Definitions.Def_ChapterHalfLineLimitCircle
import Theorems.Thm_BookProof_HalfLineLimitCircle_hlKin_not_essentiallySelfAdjointOn
open BookProof.HalfLineLimitCircle




open MeasureTheory Set BookProof.FarisLavine

noncomputable section

local notation "smoothTop" => ((⊤ : ℕ∞) : WithTop ℕ∞)

set_option maxHeartbeats 1000000 in
theorem solution : ¬ EssentiallySelfAdjointOn hlCore (-hlKin) :=
  fun h => hlKin_not_essentiallySelfAdjointOn
      ((BookProof.ConformalSignFlip.essentiallySelfAdjointOn_neg_iff hlKin).mp h)
