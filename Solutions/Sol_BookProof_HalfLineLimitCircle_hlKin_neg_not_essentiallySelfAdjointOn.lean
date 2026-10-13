-- Generated from ChapterHalfLineLimitCircle.lean — solution of BookProof.HalfLineLimitCircle.hlKin_neg_not_essentiallySelfAdjointOn
import Mathlib
import Definitions.Def_ChapterHalfLineLimitCircle
import Theorems.Thm_BookProof_HalfLineLimitCircle_hlKin_not_essentiallySelfAdjointOn
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterFarisLavineCore
open BookProof.HalfLineLimitCircle




open MeasureTheory Set BookProof.FarisLavine

noncomputable section

local notation "smoothTop" => ((⊤ : ℕ∞) : WithTop ℕ∞)

set_option maxHeartbeats 1000000 in

theorem solution : ¬ EssentiallySelfAdjointOn hlCore (-hlKin) :=
  fun h => hlKin_not_essentiallySelfAdjointOn
    ((BookProof.ConformalSignFlip.essentiallySelfAdjointOn_neg_iff hlKin).mp h)

/-! ## The core is non-trivial

The statements above would be vacuous if the core were the zero subspace, so we
exhibit an explicit element: a smooth bump centred at `2` with support the
interval `(1, 3)`, comfortably inside the open half line.
-/
