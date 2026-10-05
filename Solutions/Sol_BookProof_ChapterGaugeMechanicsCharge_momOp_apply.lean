-- Generated from ChapterGaugeMechanicsCharge.lean — solution of BookProof.ChapterGaugeMechanicsCharge.momOp_apply
import Mathlib
import Definitions.Def_ChapterGaugeMechanicsCharge





open MvPolynomial

set_option maxHeartbeats 1000000 in
theorem solution (j : Fin 2) (p : P) :
    momOp j p = (-Complex.I) • pderiv j p := rfl
