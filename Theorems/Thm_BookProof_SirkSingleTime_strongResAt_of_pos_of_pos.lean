-- Generated from ChapterSirkSingleTimeShift.lean — theorem BookProof.SirkSingleTime.strongResAt_of_pos_of_pos
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


theorem BookProof.SirkSingleTime.strongResAt_of_pos_of_pos {l m : ℝ} (hl : 0 < l) (hm : 0 < m)
    (h : StrongResAt T S l) : StrongResAt T S m := by sorry
