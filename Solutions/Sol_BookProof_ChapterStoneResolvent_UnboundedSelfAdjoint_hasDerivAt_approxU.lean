-- Generated from ChapterStoneEvolution.lean — solution of BookProof.ChapterStoneResolvent.UnboundedSelfAdjoint.hasDerivAt_approxU
import Mathlib
import Definitions.Def_ChapterStoneEvolution
open BookProof.ChapterStoneResolvent
open BookProof.ChapterStoneResolvent.UnboundedSelfAdjoint



open scoped InnerProductSpace
open Filter Topology NormedSpace


variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]

set_option maxHeartbeats 1000000 in
theorem solution (n t : ℝ) :
    HasDerivAt (fun s : ℝ => T.approxU n s) (T.approxU n t * T.yosidaGen n) t := hasDerivAt_exp_smul_const (𝕂 := ℝ) (T.yosidaGen n) t
