-- Generated from ChapterGaugeMechanicsCharge.lean — theorem BookProof.ChapterGaugeMechanicsCharge.chargeQ_comm_mul
import Mathlib
import Definitions.Def_ChapterGaugeMechanicsCharge
import Definitions.Def_ChapterA4
open BookProof.ChapterGaugeMechanicsCharge




open MvPolynomial

theorem BookProof.ChapterGaugeMechanicsCharge.chargeQ_comm_mul (g p : P) :
    chargeQ (g * p) - g * chargeQ p = (-Complex.I) • (eulerOp g * p) := by sorry
