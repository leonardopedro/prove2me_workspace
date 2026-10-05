-- Generated from ChapterQuantumGravityFock.lean — solution of BookProof.QuantumGravityFock.car_fermCre_fermCre
import Mathlib
import Definitions.Def_ChapterQuantumGravityFock
import Theorems.Thm_BookProof_QuantumGravityFock_jw_swap_erase
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
theorem solution (j k : ℕ) (u : FermAlg) :
    fermCre j (fermCre k u) + fermCre k (fermCre j u) = 0 := by

  refine Finsupp.ext fun α => ?_
  simp only [Finsupp.add_apply, Finsupp.zero_apply, fermCre_apply]
  rcases eq_or_ne j k with rfl | h
  · by_cases hj : j ∈ α
    · rw [if_pos hj, if_neg (Finset.notMem_erase j α)]
      ring
    · simp [hj]
  · by_cases hj : j ∈ α
    · by_cases hk : k ∈ α
      · rw [if_pos hj, if_pos hk, if_pos (by simp [hk, Ne.symm h] : k ∈ α.erase j),
          if_pos (by simp [hj, h] : j ∈ α.erase k), Finset.erase_right_comm (a := j) (b := k),
          ← mul_assoc, ← mul_assoc, jw_swap_erase h hj hk]
        ring
      · rw [if_pos hj, if_neg hk, if_neg (by simp [hk] : k ∉ α.erase j)]
        ring
    · by_cases hk : k ∈ α
      · rw [if_neg hj, if_pos hk, if_neg (by simp [hj] : j ∉ α.erase k)]
        ring
      · rw [if_neg hj, if_neg hk]
        ring
