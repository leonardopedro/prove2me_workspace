-- Generated from ChapterSirkGapTable.lean — solution of BookProof.SirkGapTable.richardson_qym_g4_gt
import Mathlib
import Definitions.Def_ChapterSirkGapTable
import Theorems.Thm_BookProof_SirkGapTable_richardson_qym_g4
import Definitions.Def_ChapterSirkCertifiedGap
open BookProof.SirkGapTable










noncomputable section


open BookProof.SirkCertifiedGap



variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]










variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]














open Real

set_option maxHeartbeats 1000000 in
theorem solution : qymG4L4 < richardson qymG4L3 qymG4L4 3 4 2 := by

  rw [richardson_qym_g4, qymG4L4]
  norm_num
