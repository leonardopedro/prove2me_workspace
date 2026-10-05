-- Generated from ChapterQuantumGravityFock.lean — solution of BookProof.QuantumGravityFock.car_fermAnn_fermCre_of_ne
import Mathlib
import Definitions.Def_ChapterQuantumGravityFock
import Theorems.Thm_BookProof_QuantumGravityFock_jw_swap_mixed
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
theorem solution {j k : ℕ} (h : j ≠ k) (u : FermAlg) :
    fermAnn j (fermCre k u) + fermCre k (fermAnn j u) = 0 := by

  refine Finsupp.ext fun α => ?_
  simp only [Finsupp.add_apply, Finsupp.zero_apply, fermAnn_apply, fermCre_apply]
  by_cases hj : j ∈ α
  · rw [if_pos hj, zero_add]
    by_cases hk : k ∈ α
    · rw [if_pos hk, if_pos (by simp [hj, h] : j ∈ α.erase k)]
      ring
    · rw [if_neg hk]
  · rw [if_neg hj]
    by_cases hk : k ∈ α
    · rw [if_pos hk, if_pos (by simp [hk] : k ∈ insert j α),
        if_neg (by simp [hj] : j ∉ α.erase k), Finset.erase_insert_of_ne h,
        ← mul_assoc, ← mul_assoc, jw_swap_mixed h hj hk]
      ring
    · rw [if_neg hk, if_neg (by simp [hk, Ne.symm h] : k ∉ insert j α)]
      ring
