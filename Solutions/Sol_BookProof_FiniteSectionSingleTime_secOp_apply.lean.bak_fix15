-- Generated from ChapterFiniteSectionSingleTime.lean — solution of BookProof.FiniteSectionSingleTime.secOp_apply
import Mathlib
import Definitions.Def_ChapterFiniteSectionSingleTime
import Theorems.Thm_BookProof_FiniteSectionSingleTime_inner_basisVec
open BookProof.FiniteSectionSingleTime



open scoped InnerProductSpace


open Filter Topology
open BookProof.ChapterStoneResolvent BookProof.ChapterSirkTrotterKato
open BookProof.FarisLavine BookProof.EsaClosure BookProof.StoneBridge
open BookProof.QgTruncationResolvent BookProof.SirkSingleTime BookProof.QgTimeIndependent
open BookProof.HashimotoShiftInvert
open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato

noncomputable section

variable {ι : Type*} [DecidableEq ι]

variable {ι : Type*} [DecidableEq ι]
variable (H : lpFiniteModes ι →ₗ[ℂ] L2I ι)

set_option maxHeartbeats 1000000 in
theorem solution (W : Finset ι) (x : L2I ι) :
    secOp H W x = ∑ a ∈ W, ((x : ι → ℂ) a) • projW W (H (coreVec a)) := by

  simp [secOp, inner_basisVec]
