-- Generated from ChapterFiniteSectionSingleTime.lean — solution of BookProof.FiniteSectionSingleTime.projW_apply
import Mathlib
import Definitions.Def_ChapterFiniteSectionSingleTime
import Theorems.Thm_BookProof_FiniteSectionSingleTime_inner_basisVec
import Definitions.Def_ChapterSirkTrotterKato
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterQgTruncationResolvent
import Definitions.Def_ChapterSirkSingleTimeShift
import Definitions.Def_ChapterQgTimeIndependentFlow
import Definitions.Def_ChapterComplexShiftCore
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Definitions.Def_ChapterE4
import Definitions.Def_ChapterNavierStokesIkebeKato
open BookProof.FiniteSectionSingleTime



open scoped InnerProductSpace


open Filter Topology
open BookProof.ChapterStoneResolvent BookProof.ChapterSirkTrotterKato
open BookProof.FarisLavine BookProof.EsaClosure BookProof.StoneBridge
open BookProof.QgTruncationResolvent BookProof.SirkSingleTime BookProof.QgTimeIndependent
open BookProof.HashimotoShiftInvert
open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.ChapterE4
open BookProof.NavierStokesFlow.IkebeKato

noncomputable section

variable {ι : Type*} [DecidableEq ι]

variable {ι : Type*} [DecidableEq ι]

set_option maxHeartbeats 1000000 in
theorem solution (W : Finset ι) (y : L2I ι) :
    projW W y = ∑ c ∈ W, ((y : ι → ℂ) c) • basisVec c := by

  simp [projW, inner_basisVec]
