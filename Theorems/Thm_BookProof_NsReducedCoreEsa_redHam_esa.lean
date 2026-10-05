-- Generated from ChapterNsReducedCoreEsa.lean — theorem BookProof.NsReducedCoreEsa.redHam_esa
import Definitions.Def_ChapterNavierStokesFullEulerianFock
import Definitions.Def_ChapterYangMillsHermite
import Definitions.Def_ChapterYangMillsFriedrichs
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterDirectSumEsa
import Definitions.Def_ChapterYangMillsNonAbelianEsa
import Mathlib
import Definitions.Def_ChapterNsReducedCoreEsa
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterHermiteProductCore
open BookProof.HermiteProductCore
open BookProof.NsReducedCoreEsa



open MvPolynomial
open BookProof.NsFullEuler
open BookProof.YangMillsHermite BookProof.YangMillsFriedrichs
open BookProof.HermiteProductCore BookProof.FarisLavine BookProof.DirectSumEsa
open BookProof.YangMillsNonAbelianEsa

noncomputable section

theorem BookProof.NsReducedCoreEsa.redHam_esa (nu : ℝ) (k : Fin 3 → ℝ) (n : ℕ) :
    EssentiallySelfAdjointOn (polyGaussCore (d := n * 6)) (redHam nu k n) := by sorry
