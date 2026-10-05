-- Generated from ChapterNsNonlinearFarisLavine.lean — solution of BookProof.NsNonlinearFarisLavine.nsSquareComparison_commForm
import Mathlib
import Definitions.Def_ChapterNsNonlinearFarisLavine
open BookProof.NsNonlinearFarisLavine




open MvPolynomial
open BookProof.HermiteProductCore BookProof.YangMillsHermite BookProof.FarisLavine

noncomputable section

variable {d : ℕ} (S : NsSystem d)

variable {d : ℕ} (S : NsSystem d)

set_option maxHeartbeats 1000000 in
theorem solution (x : polyGaussCore (d := d)) :
    commForm (nsKoopmanOp S) (nsSquareComparison S) x
      = (gpair ((coreRepPoly d).equiv.symm x)
          (fluxPoly S * (coreRepPoly d).equiv.symm x)).re := by

  rw [← commForm_kvn_energy S x]
  exact commForm_square_comparison (nsKoopmanCore S) _ (nsKoopmanOp_symmetricOn S) x
