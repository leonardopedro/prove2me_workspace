-- Generated from ChapterNsReducedCoreEsa.lean — solution of BookProof.NsReducedCoreEsa.redHam_esa
import Mathlib
import Definitions.Def_ChapterNsReducedCoreEsa
import Theorems.Thm_BookProof_NsReducedCoreEsa_redMomIdx_injective
import Theorems.Thm_BookProof_NsReducedCoreEsa_redHam_eq_weylPoly
import Theorems.Thm_BookProof_YangMillsNonAbelianEsa_weylPoly_esa
import Definitions.Def_ChapterNavierStokesFullEulerianFock
import Definitions.Def_ChapterYangMillsHermite
import Definitions.Def_ChapterYangMillsFriedrichs
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterDirectSumEsa
import Definitions.Def_ChapterYangMillsNonAbelianEsa
import Definitions.Def_ChapterFarisLavineCore
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
    EssentiallySelfAdjointOn (polyGaussCore (d := n * 6)) (redHam nu k n) := by

  rw [redHam_eq_weylPoly]
  exact weylPoly_esa (redMomIdx_injective n) fun m => realCoeff_redFormPoly nu k n _ _
