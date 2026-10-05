-- Generated from ChapterFermionFock.lean — solution of BookProof.FermionFock.modesF_right_subset_closure
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
theorem solution (col : ℕ → (ℕ →₀ ℂ)) (u v : FermiAlg) :
    modesF v ⊆ closureModesF col u v :=
  fun _ hx =>
    Finset.mem_union_left _ (Finset.mem_union_right _ hx)
