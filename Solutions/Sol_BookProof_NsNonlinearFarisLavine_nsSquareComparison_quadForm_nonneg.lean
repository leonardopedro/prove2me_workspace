-- Generated from ChapterNsNonlinearFarisLavine.lean — solution of BookProof.NsNonlinearFarisLavine.nsSquareComparison_quadForm_nonneg
import Mathlib
import Definitions.Def_ChapterNsNonlinearFarisLavine
import Theorems.Thm_BookProof_NsNonlinearFarisLavine_nsSquareComparison_quadForm_ge
open BookProof.NsNonlinearFarisLavine




open MvPolynomial
open BookProof.HermiteProductCore BookProof.YangMillsHermite BookProof.FarisLavine

noncomputable section

variable {d : ℕ} (S : NsSystem d)

variable {d : ℕ} (S : NsSystem d)

set_option maxHeartbeats 1000000 in
theorem solution (x : polyGaussCore (d := d)) :
    0 ≤ quadForm (nsSquareComparison S) x := le_trans (by positivity) (nsSquareComparison_quadForm_ge S x)
