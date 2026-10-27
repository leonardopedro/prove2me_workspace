-- Generated from ChapterFermionFock.lean — solution of BookProof.FermionFock.inner_toLpF
import Mathlib
import Definitions.Def_ChapterFermionFock
import Theorems.Thm_BookProof_FermionFock_inner_toLpF_of_subset
open BookProof.FermionFock




open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FarisLavine BookProof.HermiteGalerkin BookProof.FriedrichsExtension
open BookProof.YangMillsFriedrichs
open BookProof.HashimotoShiftInvert
open BookProof.FockSecondQuantization (IsHermCol IsPosCol opCol isHermCol_opCol isPosCol_opCol)

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (u v : FermiAlg) :
    (inner ℂ (toLpF u) (toLpF v) : ℂ) = ∑ S ∈ u.support, (starRingEnd ℂ) (u S) * v S := inner_toLpF_of_subset (Finset.Subset.refl _) v
