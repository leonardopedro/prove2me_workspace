-- Generated from ChapterStoneGroup.lean — theorem BookProof.ChapterStoneResolvent.UnboundedSelfAdjoint.yosida_apply
import Definitions.Def_ChapterUnitaryTransport
import Mathlib
import Definitions.Def_ChapterStoneGroup
import Definitions.Def_ChapterStoneResolvent
import Definitions.Def_ChapterSirkTrotterKato
open BookProof.ChapterStoneResolvent
open BookProof.ChapterStoneResolvent


open scoped InnerProductSpace
open Filter Topology


open BookProof.ChapterUnitaryTransport

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]


variable (T : UnboundedSelfAdjoint H)


theorem BookProof.ChapterStoneResolvent.UnboundedSelfAdjoint.yosida_apply (n : ℝ) (y : H) :
    T.yosida n y = ((n : ℂ) ^ 2) • T.resCLM (-n) y
      + (((n : ℂ) ^ 3) * Complex.I) • T.resCLM n (T.resCLM (-n) y) := by sorry
