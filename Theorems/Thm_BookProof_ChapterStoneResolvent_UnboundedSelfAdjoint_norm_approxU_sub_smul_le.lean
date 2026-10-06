-- Generated from ChapterStoneGenerator.lean — theorem BookProof.ChapterStoneResolvent.UnboundedSelfAdjoint.norm_approxU_sub_smul_le
import Mathlib
import Definitions.Def_ChapterStoneGenerator
import Definitions.Def_ChapterStoneEvolution
import Definitions.Def_ChapterStoneGroup
import Definitions.Def_ChapterStoneResolvent
import Definitions.Def_ChapterSirkTrotterKato
open BookProof.ChapterStoneResolvent
open BookProof.ChapterStoneResolvent

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]
variable (T : UnboundedSelfAdjoint H)


open scoped InnerProductSpace
open Filter Topology NormedSpace





theorem BookProof.ChapterStoneResolvent.UnboundedSelfAdjoint.norm_approxU_sub_smul_le (n h : ℝ) (x : H) :
    ‖T.approxU n h x - x - h • T.yosidaGen n x‖
      ≤ (|h| * ‖T.yosida n (T.yosidaGen n x)‖) * |h| := by
  set v : H := by sorry
