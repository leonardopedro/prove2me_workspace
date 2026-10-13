-- Generated from ChapterSmCarContinuum.lean — solution of BookProof.SmCarContinuum.norm_cCre_le
import Mathlib
import Definitions.Def_ChapterSmCarContinuum
import Definitions.Def_ChapterQuantumGravityFock
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Definitions.Def_ChapterNavierStokesDeficiency
import Definitions.Def_ChapterNavierStokesIkebeKato
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
