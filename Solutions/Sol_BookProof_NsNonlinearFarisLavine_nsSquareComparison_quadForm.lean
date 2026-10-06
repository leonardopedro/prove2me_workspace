-- Generated from ChapterNsNonlinearFarisLavine.lean — solution of BookProof.NsNonlinearFarisLavine.nsSquareComparison_quadForm
import Mathlib
import Definitions.Def_ChapterNsNonlinearFarisLavine
open BookProof.NsNonlinearFarisLavine




open MvPolynomial
open BookProof.HermiteProductCore BookProof.YangMillsHermite BookProof.FarisLavine
open BookProof.NsKoopman

noncomputable section

variable {d : ℕ} (S : NsSystem d)

variable {d : ℕ} (S : NsSystem d)

set_option maxHeartbeats 1000000 in
theorem solution (x : polyGaussCore (d := d)) :
    quadForm (nsSquareComparison S) x
      = ‖nsKoopmanOp S x‖ ^ 2 + quadForm (nsEnergyOp (d := d)) x := quadForm_square_comparison (nsKoopmanCore S) _ (nsKoopmanOp_symmetricOn S) x
