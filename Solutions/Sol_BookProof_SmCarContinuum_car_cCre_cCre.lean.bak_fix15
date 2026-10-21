-- Generated from ChapterSmCarContinuum.lean — solution of BookProof.SmCarContinuum.car_cCre_cCre
import Mathlib
import Definitions.Def_ChapterSmCarContinuum
import Theorems.Thm_BookProof_QuantumGravityFock_jw_swap_erase
open BookProof.SmCarContinuum




open BookProof.QuantumGravityFock
open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.LpNat
open BookProof.NavierStokesFlow.IkebeKato
open scoped ENNReal NNReal

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (i j : ℕ) (ψ : CFock) :
    cCre i (cCre j ψ) + cCre j (cCre i ψ) = 0 := by

  refine lp.ext (funext fun S => ?_)
  simp only [lp.coeFn_add, Pi.add_apply, lp.coeFn_zero, Pi.zero_apply, cCre_apply]
  rcases eq_or_ne i j with rfl | h
  · by_cases hi : i ∈ S
    · rw [if_pos hi, if_neg (Finset.notMem_erase i S)]
      ring
    · simp [hi]
  · by_cases hi : i ∈ S
    · by_cases hj : j ∈ S
      · rw [if_pos hi, if_pos hj, if_pos (by simp [hj, Ne.symm h] : j ∈ S.erase i),
          if_pos (by simp [hi, h] : i ∈ S.erase j), Finset.erase_right_comm (a := i) (b := j),
          ← mul_assoc, ← mul_assoc, jw_swap_erase h hi hj]
        ring
      · rw [if_pos hi, if_neg hj, if_neg (by simp [hj] : j ∉ S.erase i)]
        ring
    · by_cases hj : j ∈ S
      · rw [if_neg hi, if_pos hj, if_neg (by simp [hi] : i ∉ S.erase j)]
        ring
      · rw [if_neg hi, if_neg hj]
        ring
