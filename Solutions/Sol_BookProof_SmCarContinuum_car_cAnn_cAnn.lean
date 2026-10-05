-- Generated from ChapterSmCarContinuum.lean — solution of BookProof.SmCarContinuum.car_cAnn_cAnn
import Mathlib
import Definitions.Def_ChapterSmCarContinuum
import Theorems.Thm_BookProof_QuantumGravityFock_jw_swap_insert
open BookProof.SmCarContinuum




open BookProof.QuantumGravityFock
open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.LpNat
open BookProof.NavierStokesFlow.IkebeKato
open scoped ENNReal NNReal

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (i j : ℕ) (ψ : CFock) :
    cAnn i (cAnn j ψ) + cAnn j (cAnn i ψ) = 0 := by

  refine lp.ext (funext fun S => ?_)
  simp only [lp.coeFn_add, Pi.add_apply, lp.coeFn_zero, Pi.zero_apply, cAnn_apply]
  rcases eq_or_ne i j with rfl | h
  · by_cases hi : i ∈ S
    · simp [hi]
    · rw [if_neg hi, if_pos (Finset.mem_insert_self i S)]
      ring
  · by_cases hi : i ∈ S
    · rw [if_pos hi, if_pos (Finset.mem_insert_of_mem hi)]
      split <;> ring
    · by_cases hj : j ∈ S
      · rw [if_neg hi, if_pos hj, if_pos (Finset.mem_insert_of_mem hj)]
        ring
      · rw [if_neg hi, if_neg hj, if_neg (by simp [hj, Ne.symm h]), if_neg (by simp [hi, h]),
          Finset.insert_comm j i S, ← mul_assoc, ← mul_assoc, jw_swap_insert h hi hj]
        ring
