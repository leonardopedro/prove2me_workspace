-- Generated from ChapterFermionFock.lean — solution of BookProof.FermionFock.sum_creVecF_annF_subset
import Mathlib
import Definitions.Def_ChapterFermionFock
import Theorems.Thm_BookProof_FermionFock_annF_eq_zero_of_not_mem_modesF
open BookProof.FermionFock




open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FarisLavine BookProof.HermiteGalerkin BookProof.FriedrichsExtension
open BookProof.YangMillsFriedrichs
open BookProof.HashimotoShiftInvert
open BookProof.FockSecondQuantization (IsHermCol IsPosCol opCol isHermCol_opCol isPosCol_opCol)

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (col : ℕ → (ℕ →₀ ℂ)) (u : FermiAlg) {K L : Finset ℕ}
    (hKL : K ⊆ L) (hK : modesF u ⊆ K) :
    ∑ k ∈ K, creVecF (col k) (annF k u) = ∑ k ∈ L, creVecF (col k) (annF k u) :=
  Finset.sum_subset hKL fun k _ hk => by
      rw [annF_eq_zero_of_not_mem_modesF (fun hc => hk (hK hc)), map_zero]
