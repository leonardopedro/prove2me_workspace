-- Generated from ChapterSmCarContinuum.lean — solution of BookProof.SmCarContinuum.lipschitz_cCreS
import Mathlib
import Definitions.Def_ChapterSmCarContinuum
import Theorems.Thm_BookProof_SmCarContinuum_cCreS_sub
import Theorems.Thm_BookProof_SmCarContinuum_norm_cCreS_le
open BookProof.SmCarContinuum




open BookProof.QuantumGravityFock
open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.LpNat
open BookProof.NavierStokesFlow.IkebeKato
open scoped ENNReal NNReal

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution : LipschitzWith 1 (fun f : Ell2 => cCreS f) := by

  refine LipschitzWith.of_dist_le_mul fun x y => ?_
  rw [dist_eq_norm, dist_eq_norm, ← cCreS_sub, NNReal.coe_one, one_mul]
  exact norm_cCreS_le (x - y)
