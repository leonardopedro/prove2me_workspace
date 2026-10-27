-- Generated from ChapterSmCarContinuum.lean — solution of BookProof.SmCarContinuum.lipschitz_cAnnS
import Mathlib
import Definitions.Def_ChapterSmCarContinuum
import Theorems.Thm_BookProof_SmCarContinuum_norm_cAnnS_le
import Theorems.Thm_BookProof_SmCarContinuum_cAnnS_sub
open BookProof.SmCarContinuum




open BookProof.QuantumGravityFock
open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.LpNat
open BookProof.NavierStokesFlow.IkebeKato
open scoped ENNReal NNReal

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution : LipschitzWith 1 (fun f : Ell2 => cAnnS f) := by

  refine LipschitzWith.of_dist_le_mul fun x y => ?_
  rw [dist_eq_norm, dist_eq_norm, ← cAnnS_sub, NNReal.coe_one, one_mul]
  exact norm_cAnnS_le (x - y)
