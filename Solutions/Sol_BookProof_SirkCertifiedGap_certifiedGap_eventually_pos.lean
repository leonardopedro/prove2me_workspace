-- Generated from ChapterSirkCertifiedGap.lean — solution of BookProof.SirkCertifiedGap.certifiedGap_eventually_pos
import Mathlib
import Definitions.Def_ChapterSirkCertifiedGap
import Theorems.Thm_BookProof_SirkCertifiedGap_certifiedGap_tendsto
open BookProof.SirkCertifiedGap



noncomputable section


open scoped InnerProductSpace
open Finset Filter Topology
open BookProof.SirkFinitePrecision

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [FiniteDimensional ℂ E]

set_option maxHeartbeats 1000000 in
 := 
