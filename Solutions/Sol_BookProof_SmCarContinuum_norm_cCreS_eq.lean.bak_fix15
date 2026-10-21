-- Generated from ChapterSmCarContinuum.lean — solution of BookProof.SmCarContinuum.norm_cCreS_eq
import Mathlib
import Definitions.Def_ChapterSmCarContinuum
import Theorems.Thm_BookProof_SmCarContinuum_norm_cCreS_le
open BookProof.SmCarContinuum




open BookProof.QuantumGravityFock
open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.LpNat
open BookProof.NavierStokesFlow.IkebeKato
open scoped ENNReal NNReal

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (f : Ell2) : ‖cCreS f‖ = ‖f‖ := by

  refine le_antisymm (norm_cCreS_le f) ?_
  have hvac : ‖vac‖ = 1 := by
    rw [vac, lp.norm_single (by norm_num)]
    simp
  have hle := (cCreS f).le_opNorm vac
  rw [hvac, mul_one] at hle
  rw [← norm_oneParticle f]
  exact hle
