-- Generated from ChapterYangMillsBandBounds.lean — solution of BookProof.YangMillsBandBounds.isBandR4_ymPoly
import Mathlib
import Definitions.Def_ChapterYangMillsBandBounds
import Theorems.Thm_BookProof_YangMillsBandBounds_isBandR2_magMulOp
import Definitions.Def_ChapterHermiteRelativeBound
import Definitions.Def_ChapterYangMillsHermite
import Definitions.Def_ChapterYangMillsFriedrichs
import Definitions.Def_ChapterNavierStokesDifferentialL2
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterHermiteProductBasis
import Definitions.Def_ChapterHermiteGalerkinFriedrichs
import Definitions.Def_ChapterHermiteBandCalculus
import Definitions.Def_ChapterFockSecondQuantization
import Definitions.Def_ChapterFarisLavine













noncomputable section

open MvPolynomial BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.HermiteBand
open BookProof.FockSecondQuantization BookProof.NavierStokesFlow
open BookProof.HermiteGalerkin BookProof.FarisLavine
open BookProof.YangMillsHermite
open BookProof.YangMillsFriedrichs
open BookProof.NavierStokesFlow.DifferentialL2 BookProof.HermiteRelative

set_option maxHeartbeats 1000000 in
theorem solution (fabc : Fin 8 → Fin 8 → Fin 8 → ℝ) : IsBandR 4 4 (ymPoly fabc) := by

  rw [ymPoly]
  refine IsBandR.smul _ (IsBandR.add ?_ ?_)
  · refine IsBandR.sum _ _ fun m _ => ?_
    have hmom : IsBandR 1 1 (YangMillsHermite.momOp (ymMomIdx m)) := by
      rw [← momPoly_eq_ymMomOp]
      exact isBandR1_momPoly _
    exact ((hmom.comp hmom).le (by norm_num)).monoR (by norm_num)
  · refine IsBandR.sum _ _ fun m _ => ?_
    exact (isBandR2_magMulOp fabc (decodeSpace m) (decodeColor m)).comp
      (isBandR2_magMulOp fabc (decodeSpace m) (decodeColor m))
