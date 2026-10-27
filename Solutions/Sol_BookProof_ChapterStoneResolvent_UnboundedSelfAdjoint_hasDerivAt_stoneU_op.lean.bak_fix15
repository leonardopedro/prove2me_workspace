-- Generated from ChapterStoneGenerator.lean — solution of BookProof.ChapterStoneResolvent.UnboundedSelfAdjoint.hasDerivAt_stoneU_op
import Mathlib
import Definitions.Def_ChapterStoneGenerator
import Theorems.Thm_BookProof_ChapterStoneResolvent_UnboundedSelfAdjoint_stoneU_mem_domain
import Theorems.Thm_BookProof_ChapterStoneResolvent_UnboundedSelfAdjoint_stoneU_op
import Theorems.Thm_BookProof_ChapterStoneResolvent_UnboundedSelfAdjoint_hasDerivAt_stoneU
open BookProof.ChapterStoneResolvent
open BookProof.ChapterStoneResolvent.UnboundedSelfAdjoint



open scoped InnerProductSpace
open Filter Topology NormedSpace


variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]


variable (T : UnboundedSelfAdjoint H)

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]
variable (T : UnboundedSelfAdjoint H)

set_option maxHeartbeats 1000000 in
theorem solution (x : T.domain) (t : ℝ) :
    HasDerivAt (fun s : ℝ => T.stoneU s (x : H))
      ((-Complex.I) • T.op ⟨T.stoneU t (x : H), T.stoneU_mem_domain t x⟩) t :=
   HasDerivAt (fun s : ℝ => T.stoneU s (x : H))
        ((-Complex.I) • T.op ⟨T.stoneU
