-- Generated from ChapterSirkSingleTimeShift.lean — theorem BookProof.SirkSingleTime.strongResolventConvergence_of_strongResAt
import Definitions.Def_ChapterComplexShiftCore
import Mathlib
import Definitions.Def_ChapterSirkSingleTimeShift
import Definitions.Def_ChapterSirkTrotterKato
import Definitions.Def_ChapterStoneResolvent
import Definitions.Def_ChapterA4
open BookProof.ChapterSirkTrotterKato
open BookProof.ChapterStoneResolvent
open BookProof.ChapterStoneResolvent

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]
variable {T : UnboundedSelfAdjoint E} {S : ℕ → UnboundedSelfAdjoint E}


open scoped InnerProductSpace


open Filter Topology
open BookProof.ChapterStoneResolvent BookProof.ChapterSirkTrotterKato
open BookProof.HashimotoShiftInvert

noncomputable section


theorem BookProof.SirkSingleTime.strongResolventConvergence_of_strongResAt {l : ℝ} (hl : l ≠ 0)
    (h : StrongResAt T S l) : StrongResolventConvergence T S := by sorry
