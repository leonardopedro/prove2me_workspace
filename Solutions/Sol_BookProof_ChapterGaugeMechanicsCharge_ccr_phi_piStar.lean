-- Generated from ChapterGaugeMechanicsCharge.lean — solution of BookProof.ChapterGaugeMechanicsCharge.ccr_phi_piStar
import Mathlib
import Definitions.Def_ChapterGaugeMechanicsCharge
open BookProof.ChapterGaugeMechanicsCharge





open MvPolynomial

set_option maxHeartbeats 1000000 in
theorem solution (p : P) :
    (fieldOp 0) (momOp 1 p) - (momOp 1) (fieldOp 0 p) = 0 := by

  change X 0 * ((-Complex.I) • pderiv 1 p)
      - (-Complex.I) • pderiv 1 (X 0 * p) = 0
  rw [pderiv_mul]
  simp [pderiv_X_of_ne (by decide : (0 : Fin 2) ≠ 1)]
