-- Generated from ChapterFermionFock.lean — solution of BookProof.FermionFock.mem_modesF
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
theorem solution {u : FermiAlg} {S : FConf} (hS : S ∈ u.support) {i : ℕ} (hi : i ∈ S) :
    i ∈ modesF u := Finset.mem_biUnion.mpr ⟨S, hS, hi⟩
