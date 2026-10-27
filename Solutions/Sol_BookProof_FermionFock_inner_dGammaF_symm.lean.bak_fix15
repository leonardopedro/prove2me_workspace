-- Generated from ChapterFermionFock.lean — solution of BookProof.FermionFock.inner_dGammaF_symm
import Mathlib
import Definitions.Def_ChapterFermionFock
import Theorems.Thm_BookProof_FermionFock_inner_dGammaF_left
import Theorems.Thm_BookProof_FermionFock_inner_dGammaF_right
import Theorems.Thm_BookProof_FermionFock_modesF_left_subset_closure
import Theorems.Thm_BookProof_FermionFock_modesF_right_subset_closure
import Theorems.Thm_BookProof_FermionFock_colF_support_subset_closure
open BookProof.FermionFock




open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FarisLavine BookProof.HermiteGalerkin BookProof.FriedrichsExtension
open BookProof.YangMillsFriedrichs
open BookProof.HashimotoShiftInvert
open BookProof.FockSecondQuantization (IsHermCol IsPosCol opCol isHermCol_opCol isPosCol_opCol)

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution {col : ℕ → (ℕ →₀ ℂ)} (hherm : IsHermCol col) (u v : FermiAlg) :
    (inner ℂ (toLpF (dGammaF col u)) (toLpF v) : ℂ)
      = inner ℂ (toLpF u) (toLpF (dGammaF col v)) := by

  rw [inner_dGammaF_left col u v (modesF_left_subset_closure col u v)
      (colF_support_subset_closure col u v),
    inner_dGammaF_right col u v (modesF_right_subset_closure col u v)
      (colF_support_subset_closure col u v),
    Finset.sum_comm]
  refine Finset.sum_congr rfl fun k _ => Finset.sum_congr rfl fun j _ => ?_
  rw [hherm j k, Complex.conj_conj]
