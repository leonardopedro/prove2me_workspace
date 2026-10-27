-- Generated from ChapterFermionFock.lean — solution of BookProof.FermionFock.parityF_creF
import Mathlib
import Definitions.Def_ChapterFermionFock
import Theorems.Thm_BookProof_FermionFock_creF_apply
open BookProof.FermionFock




open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FarisLavine BookProof.HermiteGalerkin BookProof.FriedrichsExtension
open BookProof.YangMillsFriedrichs
open BookProof.HashimotoShiftInvert
open BookProof.FockSecondQuantization (IsHermCol IsPosCol opCol isHermCol_opCol isPosCol_opCol)

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (j : ℕ) (u : FermiAlg) :
    parityF (creF j u) = - creF j (parityF u) := by

  classical
  refine Finsupp.ext fun S => ?_
  rw [parityF_apply, creF_apply, Finsupp.neg_apply, creF_apply]
  by_cases hj : j ∈ S
  · rw [if_pos hj, if_pos hj, parityF_apply]
    have hcard : S.card = (S.erase j).card + 1 := by
      rw [Finset.card_erase_of_mem hj]
      have := Finset.card_pos.mpr ⟨j, hj⟩
      omega
    rw [hcard, pow_succ]
    ring
  · rw [if_neg hj, if_neg hj, mul_zero, neg_zero]
