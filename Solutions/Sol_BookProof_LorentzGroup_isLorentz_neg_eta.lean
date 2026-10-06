-- Generated from ChapterLorentzGroup.lean — solution of BookProof.LorentzGroup.isLorentz_neg_eta
import Mathlib
import Definitions.Def_ChapterLorentzGroup
open BookProof.LorentzGroup




open Matrix

set_option maxHeartbeats 1000000 in
theorem solution : IsLorentz (-eta) := by

  ext i j; fin_cases i <;> fin_cases j <;> norm_num [ Matrix.mul_apply, Fin.sum_univ_succ, eta ] ;
