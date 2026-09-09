-- Generated from ChapterSirkGapTable.lean — solution of BookProof.SirkGapTable.qcdG2M4Row_lo
import Mathlib
import Definitions.Def_ChapterSirkGapTable
open BookProof.SirkGapTable










noncomputable section


open BookProof.SirkCertifiedGap



variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]










variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]

set_option maxHeartbeats 1000000 in
theorem solution : qcdG2M4Row.lo = 1.932 ∧ qcdG2M4Row.hi = 2.043 := by

  constructor <;> norm_num [CouplingCertificate.lo, CouplingCertificate.hi, qcdG2M4Row]
