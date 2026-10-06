-- Generated from ChapterNsNonlinearFarisLavine.lean — theorem BookProof.NsNonlinearFarisLavine.nsSquareComparison_relBound
import Definitions.Def_ChapterYangMillsHermite
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterA4
import Mathlib
import Definitions.Def_ChapterNsNonlinearFarisLavine
import Definitions.Def_ChapterHermiteProductCore
open BookProof.HermiteProductCore
open BookProof.NsNonlinearFarisLavine

variable {d : ℕ} (S : NsSystem d)



open MvPolynomial
open BookProof.HermiteProductCore BookProof.YangMillsHermite BookProof.FarisLavine
open BookProof.NsKoopman

noncomputable section


theorem BookProof.NsNonlinearFarisLavine.nsSquareComparison_relBound (x : polyGaussCore (d := d)) :
    ‖nsKoopmanOp S x‖ ≤ ‖nsSquareComparison S x‖ + ‖(x : L2d d)‖ := by sorry
