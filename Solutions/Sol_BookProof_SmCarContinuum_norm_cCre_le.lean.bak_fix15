-- Generated from ChapterSmCarContinuum.lean — solution of BookProof.SmCarContinuum.norm_cCre_le
import Mathlib
import Definitions.Def_ChapterSmCarContinuum
open BookProof.SmCarContinuum




open BookProof.QuantumGravityFock
open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.LpNat
open BookProof.NavierStokesFlow.IkebeKato
open scoped ENNReal NNReal

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (i : ℕ) (ψ : CFock) : ‖cCre i ψ‖ ≤ ‖ψ‖ := by

  have h := norm_cCreL_le i ψ
  rw [one_mul] at h
  exact h
