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

namespace BookProof.ConformalSignFlip

/-- Inlined from the unpublished `ChapterConformalSignFlip` bundle
(platform-world rule: an unpublished dep cannot be imported). -/
theorem deficiencyTrivialAt_neg {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
    {D : Submodule ℂ F} (H : D →ₗ[ℂ] F) (z : ℂ) :
    DeficiencyTrivialAt D (-H) z ↔ DeficiencyTrivialAt D H (-z) := by
  constructor
  · intro h w hw
    refine h w fun v => ?_
    have hv := hw v
    rw [LinearMap.neg_apply, inner_neg_left, hv]
    ring
  · intro h w hw
    refine h w fun v => ?_
    have hv := hw v
    rw [LinearMap.neg_apply, inner_neg_left] at hv
    linear_combination -hv

/-- Essential self-adjointness is invariant under the global sign flip. -/
theorem essentiallySelfAdjointOn_neg {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
    {D : Submodule ℂ F} {H : D →ₗ[ℂ] F}
    (h : EssentiallySelfAdjointOn D H) : EssentiallySelfAdjointOn D (-H) := by
  refine ⟨?_, ?_⟩
  · rw [deficiencyTrivialAt_neg]
    exact h.2
  · rw [deficiencyTrivialAt_neg, neg_neg]
    exact h.1

theorem essentiallySelfAdjointOn_neg_iff {F : Type*} [NormedAddCommGroup F]
    [InnerProductSpace ℂ F] {D : Submodule ℂ F} (H : D →ₗ[ℂ] F) :
    EssentiallySelfAdjointOn D (-H) ↔ EssentiallySelfAdjointOn D H := by
  refine ⟨fun h => ?_, essentiallySelfAdjointOn_neg⟩
  have := essentiallySelfAdjointOn_neg h
  rwa [neg_neg] at this

end BookProof.ConformalSignFlip

set_option maxHeartbeats 1000000 in

theorem solution : ¬ EssentiallySelfAdjointOn hlCore (-hlKin) :=
  fun h => hlKin_not_essentiallySelfAdjointOn
    ((BookProof.ConformalSignFlip.essentiallySelfAdjointOn_neg_iff hlKin).mp h)

/-! ## The core is non-trivial

The statements above would be vacuous if the core were the zero subspace, so we
exhibit an explicit element: a smooth bump centred at `2` with support the
interval `(1, 3)`, comfortably inside the open half line.
-/
