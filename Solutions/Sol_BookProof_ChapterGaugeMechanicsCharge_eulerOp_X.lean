-- Generated from ChapterGaugeMechanicsCharge.lean — solution of BookProof.ChapterGaugeMechanicsCharge.eulerOp_X
import Mathlib
import Definitions.Def_ChapterGaugeMechanicsCharge
open BookProof.ChapterGaugeMechanicsCharge





open MvPolynomial

set_option maxHeartbeats 1000000 in
theorem solution (j : Fin 2) : eulerOp (X j) = X j := by

  fin_cases j <;>
    simp [eulerOp_apply,
      pderiv_X_of_ne (by decide : (0 : Fin 2) ≠ 1),
      pderiv_X_of_ne (by decide : (1 : Fin 2) ≠ 0)]
