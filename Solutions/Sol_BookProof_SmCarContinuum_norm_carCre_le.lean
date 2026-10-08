-- Generated from ChapterSmCarContinuum.lean — solution of BookProof.SmCarContinuum.norm_carCre_le
import Mathlib
import Definitions.Def_ChapterSmCarContinuum
import Theorems.Thm_BookProof_SmCarContinuum_norm_cCreS_le
open BookProof.SmCarContinuum




open BookProof.QuantumGravityFock
open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.LpNat
open BookProof.NavierStokesFlow.IkebeKato
open scoped ENNReal NNReal

noncomputable section

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]

set_option maxHeartbeats 1000000 in
theorem solution (b : HilbertBasis ℕ ℂ H) (v : H) : ‖carCre b v‖ ≤ ‖v‖ := by

  rw [carCre]
  calc ‖cCreS (b.repr v)‖ ≤ ‖b.repr v‖ := norm_cCreS_le _
    _ = ‖v‖ := b.repr.norm_map v

omit [CompleteSpace H] in
