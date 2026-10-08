-- Generated from ChapterNsNonlinearFarisLavine.lean — theorem BookProof.NsNonlinearFarisLavine.nsSquareComparison_symmetricOn
import Definitions.Def_ChapterYangMillsHermite
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterA4
import Mathlib
import Definitions.Def_ChapterNsNonlinearFarisLavine
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterHermiteProductCore
open BookProof.HermiteProductCore
open BookProof.NsNonlinearFarisLavine



open MvPolynomial
open BookProof.HermiteProductCore BookProof.YangMillsHermite BookProof.FarisLavine
open BookProof.NsKoopman

noncomputable section

variable {d : ℕ} (S : NsSystem d)


theorem BookProof.NsNonlinearFarisLavine.nsSquareComparison_symmetricOn :
    SymmetricOn (polyGaussCore (d := d)) (nsSquareComparison S) := by sorry
