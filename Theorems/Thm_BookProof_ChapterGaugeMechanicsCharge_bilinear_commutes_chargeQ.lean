-- Generated from ChapterGaugeMechanicsCharge.lean — theorem BookProof.ChapterGaugeMechanicsCharge.bilinear_commutes_chargeQ
import Mathlib
import Definitions.Def_ChapterGaugeMechanicsCharge
import Definitions.Def_ChapterA4




open MvPolynomial

theorem BookProof.ChapterGaugeMechanicsCharge.bilinear_commutes_chargeQ (j k : Fin 2) (p : P) :
    chargeQ (X j * pderiv k p) = X j * pderiv k (chargeQ p) := by sorry
