-- Generated from ChapterGaugeMechanicsCharge.lean — solution of BookProof.ChapterGaugeMechanicsCharge.bilinear_commutes_chargeQ
import Mathlib
import Definitions.Def_ChapterGaugeMechanicsCharge
import Theorems.Thm_BookProof_ChapterGaugeMechanicsCharge_chargeQ_eq_euler
import Theorems.Thm_BookProof_ChapterGaugeMechanicsCharge_euler_comm_bilinear
open BookProof.ChapterGaugeMechanicsCharge





open MvPolynomial

set_option maxHeartbeats 1000000 in
theorem solution (j k : Fin 2) (p : P) :
    chargeQ (X j * pderiv k p) = X j * pderiv k (chargeQ p) := by

  rw [chargeQ_eq_euler, chargeQ_eq_euler, euler_comm_bilinear j k p]
  simp only [map_add, Derivation.map_smul_of_tower, smul_add, mul_add,
    mul_smul_comm]
