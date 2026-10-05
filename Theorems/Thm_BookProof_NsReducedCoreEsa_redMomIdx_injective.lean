-- Generated from ChapterNsReducedCoreEsa.lean — theorem BookProof.NsReducedCoreEsa.redMomIdx_injective
import Definitions.Def_ChapterNavierStokesFullEulerianFock
import Definitions.Def_ChapterYangMillsHermite
import Definitions.Def_ChapterYangMillsFriedrichs
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterDirectSumEsa
import Definitions.Def_ChapterYangMillsNonAbelianEsa
import Mathlib
import Definitions.Def_ChapterNsReducedCoreEsa
open BookProof.NsReducedCoreEsa



open MvPolynomial
open BookProof.NsFullEuler
open BookProof.YangMillsHermite BookProof.YangMillsFriedrichs
open BookProof.HermiteProductCore BookProof.FarisLavine BookProof.DirectSumEsa
open BookProof.YangMillsNonAbelianEsa

noncomputable section

theorem BookProof.NsReducedCoreEsa.redMomIdx_injective (n : ℕ) : Function.Injective (redMomIdx n) := by sorry
