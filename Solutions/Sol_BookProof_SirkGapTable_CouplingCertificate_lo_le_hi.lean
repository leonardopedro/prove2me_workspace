-- Generated from ChapterSirkGapTable.lean — solution of BookProof.SirkGapTable.CouplingCertificate.lo_le_hi
import Mathlib
import Definitions.Def_ChapterSirkGapTable
open BookProof.SirkGapTable
open BookProof.SirkGapTable.CouplingCertificate










noncomputable section


open BookProof.SirkCertifiedGap



variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]

set_option maxHeartbeats 1000000 in
theorem solution (c : CouplingCertificate) : c.lo ≤ c.hi := by

  have := c.width_nonneg
  simp only [CouplingCertificate.lo, CouplingCertificate.hi]
  linarith
