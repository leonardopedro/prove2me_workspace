-- Generated from ChapterNsReducedCoreEsa.lean — solution of BookProof.NsReducedCoreEsa.redHam_eq_weylPoly
import Mathlib
import Definitions.Def_ChapterNsReducedCoreEsa
import Definitions.Def_ChapterNavierStokesFullEulerianFock
import Definitions.Def_ChapterYangMillsHermite
import Definitions.Def_ChapterYangMillsFriedrichs
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterDirectSumEsa
import Definitions.Def_ChapterYangMillsNonAbelianEsa
import Definitions.Def_ChapterHermiteProductCore
open BookProof.NsReducedCoreEsa




open MvPolynomial
open BookProof.NsFullEuler
open BookProof.YangMillsHermite BookProof.YangMillsFriedrichs
open BookProof.HermiteProductCore BookProof.FarisLavine BookProof.DirectSumEsa
open BookProof.YangMillsNonAbelianEsa
open BookProof.HermiteProductCore

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (nu : ℝ) (k : Fin 3 → ℝ) (n : ℕ) :
    redHam nu k n = weylPoly (redMomIdx n) (redFieldPoly nu k n) := rfl
