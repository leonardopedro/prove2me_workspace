-- Generated from ChapterSirkSingleTimeShift.lean — theorem BookProof.SirkSingleTime.strongResAt_neg
import Definitions.Def_ChapterSirkTrotterKato
import Definitions.Def_ChapterComplexShiftCore
import Mathlib
import Definitions.Def_ChapterSirkSingleTimeShift
import Definitions.Def_ChapterStoneResolvent
open BookProof.SirkSingleTime

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]
variable {T : UnboundedSelfAdjoint E} {S : ℕ → UnboundedSelfAdjoint E}


open scoped InnerProductSpace


open Filter Topology
open BookProof.ChapterStoneResolvent BookProof.ChapterSirkTrotterKato
open BookProof.HashimotoShiftInvert

noncomputable section


theorem BookProof.SirkSingleTime.strongResAt_neg {l : ℝ} (hl : l ≠ 0) (h : StrongResAt T S l) :
    StrongResAt T S (-l) := by sorry
