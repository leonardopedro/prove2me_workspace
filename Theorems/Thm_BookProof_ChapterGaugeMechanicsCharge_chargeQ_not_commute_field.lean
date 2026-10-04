-- Generated from ChapterGaugeMechanicsCharge.lean — theorem BookProof.ChapterGaugeMechanicsCharge.chargeQ_not_commute_field
import Mathlib
import Definitions.Def_ChapterGaugeMechanicsCharge
import Definitions.Def_ChapterA4
open BookProof.ChapterGaugeMechanicsCharge




open MvPolynomial

theorem BookProof.ChapterGaugeMechanicsCharge.chargeQ_not_commute_field (j : Fin 2) (p : P) :
    chargeQ (X j * p) - X j * chargeQ p = (-Complex.I) • (X j * p) := by sorry
