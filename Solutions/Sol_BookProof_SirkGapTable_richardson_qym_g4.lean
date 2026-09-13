-- Generated from ChapterSirkGapTable.lean — solution of BookProof.SirkGapTable.richardson_qym_g4
import Mathlib
import Definitions.Def_ChapterSirkGapTable
import Definitions.Def_ChapterSirkCertifiedGap
open BookProof.SirkGapTable










noncomputable section


open BookProof.SirkCertifiedGap



variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]










variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]














open Real

set_option maxHeartbeats 1000000 in
theorem solution :
    richardson qymG4L3 qymG4L4 3 4 2 = 27999423 / 3500000 := by

  have hr : ((4 : ℝ) / 3) ^ (2 : ℝ) = 16 / 9 := by
    rw [show (2 : ℝ) = ((2 : ℕ) : ℝ) by norm_num, rpow_natCast]
    norm_num
  rw [richardson, hr, qymG4L3, qymG4L4]
  norm_num
