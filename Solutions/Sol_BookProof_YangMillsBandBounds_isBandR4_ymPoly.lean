-- Generated from ChapterYangMillsBandBounds.lean — solution of BookProof.YangMillsBandBounds.isBandR4_ymPoly
import Mathlib
import Definitions.Def_ChapterYangMillsBandBounds
import Theorems.Thm_BookProof_YangMillsBandBounds_isBandR2_magMulOp
open BookProof.YangMillsBandBounds













noncomputable section

open MvPolynomial BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.HermiteBand BookProof.HermiteBandHigher BookProof.QuadFockEsa
open BookProof.FockSecondQuantization BookProof.NavierStokesFlow
open BookProof.HermiteGalerkin BookProof.FarisLavine
open BookProof.YangMillsHermite BookProof.FullQuadratic BookProof.YangMillsAbelianEsa
open BookProof.YangMillsFriedrichs BookProof.YmAbelianFock
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
