-- Generated from ChapterFockSchurEsa.lean — solution of BookProof.FockSchur.normSq_toLp
import Mathlib
import Definitions.Def_ChapterFockSchurEsa
import Theorems.Thm_BookProof_FockSchur_normSq_toLp_of_subset
open BookProof.FockSchur




open BookProof.FockSecondQuantization BookProof.CoreBounds
open BookProof.FarisLavine BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent
open BookProof.YangMillsFriedrichs

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (u : FockAlg) : ‖toLp u‖ ^ 2 = ∑ α ∈ u.support, ‖u α‖ ^ 2 := normSq_toLp_of_subset (Finset.Subset.refl _)
