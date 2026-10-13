-- Generated from ChapterNsReducedCoreEsa.lean — solution of BookProof.NsReducedCoreEsa.redMomIdx_eq
import Mathlib
import Definitions.Def_ChapterNsReducedCoreEsa
import Definitions.Def_ChapterNavierStokesFullEulerianFock
import Definitions.Def_ChapterYangMillsHermite
import Definitions.Def_ChapterYangMillsFriedrichs
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterDirectSumEsa
import Definitions.Def_ChapterYangMillsNonAbelianEsa
open BookProof.NsReducedCoreEsa




open MvPolynomial
open BookProof.NsFullEuler
open BookProof.YangMillsHermite BookProof.YangMillsFriedrichs
open BookProof.HermiteProductCore BookProof.FarisLavine BookProof.DirectSumEsa
open BookProof.YangMillsNonAbelianEsa

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (n : ℕ) (m : Fin (n * 6)) : redMomIdx n m = m := by

  simp only [redMomIdx, redIdx, Prod.mk.eta, Equiv.apply_symm_apply]
