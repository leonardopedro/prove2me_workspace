-- Generated from ChapterSirkCertifiedGap.lean — solution of BookProof.SirkCertifiedGap.qcdG2M4_lower_pos
import Mathlib
import Definitions.Def_ChapterSirkCertifiedGap
import Theorems.Thm_BookProof_SirkCertifiedGap_qcdG2M4_lower
open BookProof.SirkCertifiedGap











noncomputable section


open scoped InnerProductSpace
open Finset Filter Topology
open BookProof.SirkFinitePrecision

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [FiniteDimensional ℂ E]

set_option maxHeartbeats 1000000 in
theorem solution : 0 < qcdG2M4.lower := by

  rw [qcdG2M4_lower]; norm_num
