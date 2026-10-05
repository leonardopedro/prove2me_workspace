-- Generated from ChapterGaugeMechanicsCharge.lean — solution of BookProof.ChapterGaugeMechanicsCharge.ccr_phi_pi
import Mathlib
import Definitions.Def_ChapterGaugeMechanicsCharge
open BookProof.ChapterGaugeMechanicsCharge





open MvPolynomial

set_option maxHeartbeats 1000000 in
theorem solution (p : P) :
    (fieldOp 0) (momOp 0 p) - (momOp 0) (fieldOp 0 p) = Complex.I • p := by

  change X 0 * ((-Complex.I) • pderiv 0 p)
      - (-Complex.I) • pderiv 0 (X 0 * p) = Complex.I • p
  rw [pderiv_mul]
  simp
