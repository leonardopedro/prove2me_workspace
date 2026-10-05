-- Generated from ChapterGaugeMechanicsCharge.lean — theorem BookProof.ChapterGaugeMechanicsCharge.chargeQ_homogeneous
import Mathlib
import Definitions.Def_ChapterGaugeMechanicsCharge
open BookProof.ChapterGaugeMechanicsCharge




open MvPolynomial

theorem BookProof.ChapterGaugeMechanicsCharge.chargeQ_homogeneous {n : ℕ} {p : P} (hp : p.IsHomogeneous n) :
    chargeQ p = (-Complex.I * (n + 2)) • p := by sorry
