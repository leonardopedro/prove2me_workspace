-- Generated from ChapterFermionFock.lean — solution of BookProof.FermionFock.creVecF_apply
import Mathlib
import Definitions.Def_ChapterFermionFock
open BookProof.FermionFock




open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FarisLavine BookProof.HermiteGalerkin BookProof.FriedrichsExtension
open BookProof.YangMillsFriedrichs
open BookProof.HashimotoShiftInvert
open BookProof.FockSecondQuantization (IsHermCol IsPosCol opCol isHermCol_opCol isPosCol_opCol)

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (v : ℕ →₀ ℂ) (x : FermiAlg) :
    creVecF v x = ∑ j ∈ v.support, v j • creF j x := by

  simp [creVecF, LinearMap.sum_apply]
