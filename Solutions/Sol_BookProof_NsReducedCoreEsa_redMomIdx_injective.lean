-- Generated from ChapterNsReducedCoreEsa.lean — solution of BookProof.NsReducedCoreEsa.redMomIdx_injective
import Mathlib
import Definitions.Def_ChapterNsReducedCoreEsa
import Theorems.Thm_BookProof_NsReducedCoreEsa_redMomIdx_eq
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
theorem solution (n : ℕ) : Function.Injective (redMomIdx n) := by

  intro a b h
  rwa [redMomIdx_eq, redMomIdx_eq] at h
