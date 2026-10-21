-- Generated from ChapterFermionFock.lean — solution of BookProof.FermionFock.dGammaF_eq_sum
import Mathlib
import Definitions.Def_ChapterFermionFock
import Theorems.Thm_BookProof_FermionFock_dGammaF_eq_sum_aux
open BookProof.FermionFock




open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FarisLavine BookProof.HermiteGalerkin BookProof.FriedrichsExtension
open BookProof.YangMillsFriedrichs
open BookProof.HashimotoShiftInvert
open BookProof.FockSecondQuantization (IsHermCol IsPosCol opCol isHermCol_opCol isPosCol_opCol)

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (col : ℕ → (ℕ →₀ ℂ)) {u : FermiAlg} {K : Finset ℕ} (hK : modesF u ⊆ K) :
    dGammaF col u = ∑ k ∈ K, creVecF (col k) (annF k u) := dGammaF_eq_sum_aux col u K hK
