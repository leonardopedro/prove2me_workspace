-- Generated from ChapterLorentzGroup.lean — solution of BookProof.LorentzGroup.eta_mul_self
import Mathlib
import Definitions.Def_ChapterLorentzGroup
open BookProof.LorentzGroup




open Matrix

set_option maxHeartbeats 1000000 in
theorem solution : eta * eta = 1 := by

  ext i j; fin_cases i <;> fin_cases j <;> simp [ eta, Matrix.mul_apply ] ;
  all_goals norm_num [ Fin.sum_univ_succ, Fin.sum_univ_zero ] ;
