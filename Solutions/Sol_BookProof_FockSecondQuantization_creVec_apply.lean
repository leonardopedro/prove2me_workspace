-- Generated from ChapterFockSecondQuantization.lean — solution of BookProof.FockSecondQuantization.creVec_apply
import Mathlib
import Definitions.Def_ChapterFockSecondQuantization
open BookProof.FockSecondQuantization








open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FarisLavine BookProof.YangMillsFriedrichs
open BookProof.HermiteGalerkin BookProof.FriedrichsExtension
open BookProof.HashimotoShiftInvert

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (v : ℕ →₀ ℂ) (x : FockAlg) :
    creVec v x = ∑ j ∈ v.support, v j • creA j x := by

  simp [creVec, LinearMap.sum_apply]
