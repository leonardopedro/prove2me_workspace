-- Generated from ChapterGaugeMechanicsCharge.lean — solution of BookProof.ChapterGaugeMechanicsCharge.eulerOp_apply
import Mathlib
import Definitions.Def_ChapterGaugeMechanicsCharge





open MvPolynomial

set_option maxHeartbeats 1000000 in
theorem solution (p : P) :
    eulerOp p = X 0 * pderiv 0 p + X 1 * pderiv 1 p := rfl
