-- Generated from ChapterFermionFock.lean — solution of BookProof.FermionFock.parityF_annF
import Mathlib
import Definitions.Def_ChapterFermionFock
import Theorems.Thm_BookProof_FermionFock_annF_apply
open BookProof.FermionFock




open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FarisLavine BookProof.HermiteGalerkin BookProof.FriedrichsExtension
open BookProof.YangMillsFriedrichs
open BookProof.HashimotoShiftInvert
open BookProof.FockSecondQuantization (IsHermCol IsPosCol opCol isHermCol_opCol isPosCol_opCol)

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (j : ℕ) (u : FermiAlg) :
    parityF (annF j u) = - annF j (parityF u) := by

  classical
  refine Finsupp.ext fun S => ?_
  rw [parityF_apply, annF_apply, Finsupp.neg_apply, annF_apply]
  by_cases hj : j ∈ S
  · rw [if_pos hj, if_pos hj, mul_zero, neg_zero]
  · rw [if_neg hj, if_neg hj, parityF_apply,
      Finset.card_insert_of_notMem hj, pow_succ]
    ring
