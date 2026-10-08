-- Generated from ChapterSirkSingleTimeShift.lean — theorem BookProof.SirkSingleTime.strongResAt_of_abs_sub_lt
import Definitions.Def_ChapterSirkTrotterKato
import Definitions.Def_ChapterComplexShiftCore
import Mathlib
import Definitions.Def_ChapterSirkSingleTimeShift
import Definitions.Def_ChapterStoneResolvent
open BookProof.SirkSingleTime


open scoped InnerProductSpace


open Filter Topology
open BookProof.ChapterStoneResolvent BookProof.ChapterSirkTrotterKato
open BookProof.HashimotoShiftInvert

noncomputable section

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]

variable {T : UnboundedSelfAdjoint E} {S : ℕ → UnboundedSelfAdjoint E}

theorem BookProof.SirkSingleTime.strongResAt_of_abs_sub_lt {l m : ℝ} (hl : l ≠ 0) (hm : m ≠ 0)
    (hlt : |m - l| < |l|) (h : StrongResAt T S l) : StrongResAt T S m := by sorry
