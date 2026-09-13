-- Generated from ChapterSirkGapTable.lean — solution of BookProof.SirkGapTable.strongCoupling_lt
import Mathlib
import Definitions.Def_ChapterSirkGapTable
import Definitions.Def_ChapterSirkCertifiedGap
open BookProof.SirkGapTable










noncomputable section


open BookProof.SirkCertifiedGap



variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]










variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]

set_option maxHeartbeats 1000000 in
theorem solution {g₁ g₂ : ℝ} (h0 : 0 ≤ g₁) (h : g₁ < g₂) :
    strongCoupling g₁ < strongCoupling g₂ := by

  have : g₁ ^ 2 < g₂ ^ 2 := by nlinarith
  simpa [strongCoupling] using by linarith
