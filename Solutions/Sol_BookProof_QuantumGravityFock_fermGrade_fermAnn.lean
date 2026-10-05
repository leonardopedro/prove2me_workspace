-- Generated from ChapterQuantumGravityFock.lean — solution of BookProof.QuantumGravityFock.fermGrade_fermAnn
import Mathlib
import Definitions.Def_ChapterQuantumGravityFock
import Theorems.Thm_BookProof_QuantumGravityFock_fermAnn_apply
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
    fermGrade (fermAnn j u) = - fermAnn j (fermGrade u) := by

  refine Finsupp.ext fun α => ?_
  rw [fermGrade_apply, fermAnn_apply, Finsupp.neg_apply, fermAnn_apply]
  by_cases hj : j ∈ α
  · simp [hj]
  · rw [if_neg hj, if_neg hj, fermGrade_apply, Finset.card_insert_of_notMem hj, pow_succ]
    ring
