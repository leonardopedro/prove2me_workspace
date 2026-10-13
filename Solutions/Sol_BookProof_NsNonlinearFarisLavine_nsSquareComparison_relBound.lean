-- Generated from ChapterNsNonlinearFarisLavine.lean — solution of BookProof.NsNonlinearFarisLavine.nsSquareComparison_relBound
import Mathlib
import Definitions.Def_ChapterNsNonlinearFarisLavine
import Definitions.Def_ChapterYangMillsHermite
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterA4
import Definitions.Def_ChapterHermiteProductCore
open BookProof.NsNonlinearFarisLavine




open MvPolynomial
open BookProof.HermiteProductCore BookProof.YangMillsHermite BookProof.FarisLavine
open BookProof.NsKoopman
open BookProof.HermiteProductCore

noncomputable section

variable {d : ℕ} (S : NsSystem d)

variable {d : ℕ} (S : NsSystem d)

set_option maxHeartbeats 1000000 in
theorem solution (x : polyGaussCore (d := d)) :
    ‖nsKoopmanOp S x‖ ≤ ‖nsSquareComparison S x‖ + ‖(x : L2d d)‖ :=
  norm_le_square_comparison (nsKoopmanCore S) _ (nsKoopmanOp_symmetricOn S)
      nsEnergyOp_quadForm_nonneg x
