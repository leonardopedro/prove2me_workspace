-- Generated from ChapterNsNonlinearFarisLavine.lean — solution of BookProof.NsNonlinearFarisLavine.nsSquareComparison_quadForm_ge
import Mathlib
import Definitions.Def_ChapterNsNonlinearFarisLavine
import Theorems.Thm_BookProof_NsNonlinearFarisLavine_nsSquareComparison_quadForm
open BookProof.NsNonlinearFarisLavine




open MvPolynomial
open BookProof.HermiteProductCore BookProof.YangMillsHermite BookProof.FarisLavine
open BookProof.NsKoopman

noncomputable section

variable {d : ℕ} (S : NsSystem d)

variable {d : ℕ} (S : NsSystem d)

set_option maxHeartbeats 1000000 in
theorem solution (x : polyGaussCore (d := d)) :
    ‖(x : L2d d)‖ ^ 2 ≤ quadForm (nsSquareComparison S) x := by

  rw [nsSquareComparison_quadForm]
  have := nsEnergyOp_quadForm_ge x
  nlinarith [sq_nonneg ‖nsKoopmanOp S x‖]
