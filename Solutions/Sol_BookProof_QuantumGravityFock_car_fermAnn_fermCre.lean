-- Generated from ChapterQuantumGravityFock.lean — solution of BookProof.QuantumGravityFock.car_fermAnn_fermCre
import Mathlib
import Definitions.Def_ChapterQuantumGravityFock
import Theorems.Thm_BookProof_QuantumGravityFock_jwSign_mul_self
import Theorems.Thm_BookProof_QuantumGravityFock_fermAnn_apply
import Theorems.Thm_BookProof_QuantumGravityFock_fermCre_apply
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
    fermAnn j (fermCre j u) + fermCre j (fermAnn j u) = u := by

  refine Finsupp.ext fun α => ?_
  simp only [Finsupp.add_apply, fermAnn_apply, fermCre_apply]
  by_cases hj : j ∈ α
  · simp only [if_pos hj, zero_add, if_neg (Finset.notMem_erase j α), jwSign_erase_self,
      Finset.insert_erase hj, ← mul_assoc, jwSign_mul_self, one_mul]
  · simp only [if_neg hj, add_zero, if_pos (Finset.mem_insert_self j α), jwSign_insert_self,
      Finset.erase_insert hj, ← mul_assoc, jwSign_mul_self, one_mul]
