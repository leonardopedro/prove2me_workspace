-- Generated from ChapterGaugeMechanicsCharge.lean — solution of BookProof.ChapterGaugeMechanicsCharge.chargeQ_eq_euler
import Mathlib
import Definitions.Def_ChapterGaugeMechanicsCharge
open BookProof.ChapterGaugeMechanicsCharge





open MvPolynomial

set_option maxHeartbeats 1000000 in
theorem solution (p : P) :
    chargeQ p = (-Complex.I) • (eulerOp p + (2 : ℂ) • p) := by

  change (-Complex.I) • pderiv 0 (X 0 * p) + (-Complex.I) • pderiv 1 (X 1 * p)
      = (-Complex.I) • (X 0 * pderiv 0 p + X 1 * pderiv 1 p + (2 : ℂ) • p)
  rw [pderiv_mul, pderiv_mul]
  simp
  module
