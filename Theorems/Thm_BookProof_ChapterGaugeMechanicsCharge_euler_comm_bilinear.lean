-- Generated from ChapterGaugeMechanicsCharge.lean — theorem BookProof.ChapterGaugeMechanicsCharge.euler_comm_bilinear
import Mathlib
import Definitions.Def_ChapterGaugeMechanicsCharge
import Definitions.Def_ChapterA4




open MvPolynomial

theorem BookProof.ChapterGaugeMechanicsCharge.euler_comm_bilinear (j k : Fin 2) (p : P) :
    eulerOp (X j * pderiv k p) = X j * pderiv k (eulerOp p) := by sorry
