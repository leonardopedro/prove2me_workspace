-- Generated from ChapterStoneGroup.lean — theorem BookProof.ChapterStoneResolvent.UnboundedSelfAdjoint.res_sub
import Mathlib
import Definitions.Def_ChapterStoneGroup
open BookProof.ChapterStoneResolvent
open BookProof.ChapterStoneResolvent.UnboundedSelfAdjoint

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]
variable (T : UnboundedSelfAdjoint H)


open scoped InnerProductSpace
open Filter Topology


open BookProof.ChapterUnitaryTransport

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]


variable (T : UnboundedSelfAdjoint H)

theorem BookProof.ChapterStoneResolvent.UnboundedSelfAdjoint.res_sub {l m : ℝ} (hl : l ≠ 0) (hm : m ≠ 0) (y : H) :
    T.resCLM l y - T.resCLM m y
      = (((l : ℂ) - (m : ℂ)) * Complex.I) • T.resCLM l (T.resCLM m y) := by sorry
