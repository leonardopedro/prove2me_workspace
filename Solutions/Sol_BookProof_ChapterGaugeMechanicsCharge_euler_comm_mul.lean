-- Generated from ChapterGaugeMechanicsCharge.lean — solution of BookProof.ChapterGaugeMechanicsCharge.euler_comm_mul
import Mathlib
import Definitions.Def_ChapterGaugeMechanicsCharge
open BookProof.ChapterGaugeMechanicsCharge





open MvPolynomial

set_option maxHeartbeats 1000000 in
theorem solution (g p : P) :
    eulerOp (g * p) - g * eulerOp p = (eulerOp g) * p := by

  simp only [eulerOp_apply, pderiv_mul]
  ring
