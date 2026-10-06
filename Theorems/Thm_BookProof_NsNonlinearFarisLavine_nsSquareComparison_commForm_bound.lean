-- Generated from ChapterNsNonlinearFarisLavine.lean — theorem BookProof.NsNonlinearFarisLavine.nsSquareComparison_commForm_bound
import Definitions.Def_ChapterYangMillsHermite
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterA4
import Mathlib
import Definitions.Def_ChapterNsNonlinearFarisLavine
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterHermiteProductCore
open BookProof.HermiteProductCore
open BookProof.NsNonlinearFarisLavine

variable {d : ℕ} (S : NsSystem d)



open MvPolynomial
open BookProof.HermiteProductCore BookProof.YangMillsHermite BookProof.FarisLavine
open BookProof.NsKoopman

noncomputable section


theorem BookProof.NsNonlinearFarisLavine.nsSquareComparison_commForm_bound {L : ℝ} (hL : ∀ i, S.lam i ≤ L) (hL0 : 0 ≤ L)
    (x : polyGaussCore (d := d)) :
    |commForm (nsKoopmanOp S) (nsSquareComparison S) x|
      ≤ (2 * S.nu * L) * quadForm (nsSquareComparison S) x := by sorry
