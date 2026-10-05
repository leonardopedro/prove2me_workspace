-- Generated from ChapterQuantumGravityFock.lean — solution of BookProof.QuantumGravityFock.fermGrade_fermCre
import Mathlib
import Definitions.Def_ChapterQuantumGravityFock
import Theorems.Thm_BookProof_QuantumGravityFock_fermCre_apply
import Theorems.Thm_BookProof_QuantumGravityFock_fermGrade_apply
open BookProof.QuantumGravityFock




open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.NavierStokesFlow.FockOfFock BookProof.NavierStokesFlow.FullEsa
open BookProof.FarisLavine BookProof.StoneBridge BookProof.EsaClosure
open BookProof.ChapterStoneResolvent BookProof.YangMillsFriedrichs
open BookProof.HermiteGalerkin BookProof.HashimotoShiftInvert
open BookProof.FockSecondQuantization

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (j : ℕ) (u : FermAlg) :
    fermGrade (fermCre j u) = - fermCre j (fermGrade u) := by

  refine Finsupp.ext fun α => ?_
  rw [fermGrade_apply, fermCre_apply, Finsupp.neg_apply, fermCre_apply]
  by_cases hj : j ∈ α
  · rw [if_pos hj, if_pos hj, fermGrade_apply, Finset.card_erase_of_mem hj]
    have hc : 1 ≤ α.card := Finset.card_pos.mpr ⟨j, hj⟩
    have hpow : ((-1 : ℂ)) ^ α.card = -((-1 : ℂ) ^ (α.card - 1)) := by
      conv_lhs => rw [show α.card = (α.card - 1) + 1 from by omega]
      rw [pow_succ]
      ring
    rw [hpow]
    ring
  · simp [hj]
