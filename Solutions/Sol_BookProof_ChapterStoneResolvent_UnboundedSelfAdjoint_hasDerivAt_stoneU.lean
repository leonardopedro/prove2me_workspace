-- Generated from ChapterStoneGenerator.lean — solution of BookProof.ChapterStoneResolvent.UnboundedSelfAdjoint.hasDerivAt_stoneU
import Mathlib
import Definitions.Def_ChapterStoneGenerator
import Theorems.Thm_BookProof_ChapterStoneResolvent_UnboundedSelfAdjoint_hasDerivAt_stoneU_zero
import Theorems.Thm_BookProof_ChapterStoneResolvent_UnboundedSelfAdjoint_stoneU_apply_stoneU
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
    HasDerivAt (fun s : ℝ => T.stoneU s (x : H)) (T.stoneU t ((-Complex.I) • T.op x)) t :=
  vAt_stoneU (x : T.domain) (t : ℝ) :
      HasDerivAt (fun s : ℝ => T.stoneU s (x : H)) (T.stoneU t ((-Complex.I) • T.op x)) t := by
    have hz : HasDerivAt (fun u : ℝ => T.stoneU u (x : H)) ((-Complex.I) • T.op x) (t - t) := by
      simpa using T.hasDerivAt_stoneU_zero x
    have h2 : HasDerivAt (fun s : ℝ => T.stoneU (s - t) (x : H)) ((-Complex.I) • T.op x) t :=
      HasDerivAt.comp_sub_const t t hz
    have h3 : HasDerivAt (fun s : ℝ => T.stoneU t (T.stoneU (s - t) (x : H)))
        (T.stoneU t ((-Complex.I) • T.op x)) t :=
      ((T.stoneU t).restrictScalars ℝ).hasFDerivAt.comp_hasDerivAt t h2
    have heq : (fun s : ℝ => T.stoneU t (T.stoneU (s - t) (x : H)))
        = fun s : ℝ => T.stoneU s
