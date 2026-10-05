-- Generated from ChapterSmCarContinuum.lean — solution of BookProof.SmCarContinuum.cCreS_single
import Mathlib
import Definitions.Def_ChapterSmCarContinuum
open BookProof.SmCarContinuum




open BookProof.QuantumGravityFock
open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.LpNat
open BookProof.NavierStokesFlow.IkebeKato
open scoped ENNReal NNReal

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (i : ℕ) : cCreS (lp.single 2 i (1 : ℂ)) = cCre i := by

  refine ContinuousLinearMap.ext fun ψ => lp.ext (funext fun S => ?_)
  rw [cCreS_apply, cCre_apply]
  by_cases h : i ∈ S
  · rw [if_pos h, Finset.sum_eq_single i]
    · simp
    · intro j _ hj
      simp [lp.single_apply, hj]
    · intro hi
      exact absurd h hi
  · rw [if_neg h]
    refine Finset.sum_eq_zero fun j hj => ?_
    have hne : j ≠ i := fun e => h (e ▸ hj)
    simp [lp.single_apply, hne]
