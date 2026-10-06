-- Generated from ChapterNsNonlinearFarisLavine.lean — theorem BookProof.NsNonlinearFarisLavine.nsKoopman_esa_of_squareComparison_esa
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


theorem BookProof.NsNonlinearFarisLavine.nsKoopman_esa_of_squareComparison_esa
    (hN : EssentiallySelfAdjointOn (polyGaussCore (d := d)) (nsSquareComparison S)) :
    EssentiallySelfAdjointOn (polyGaussCore (d := d)) (nsKoopmanOp S) := by sorry
