-- Generated from ChapterYangMillsBandBounds.lean — solution of BookProof.YangMillsBandBounds.isBandR4_ymPoly
import Mathlib
import Definitions.Def_ChapterYangMillsBandBounds
import Theorems.Thm_BookProof_YangMillsBandBounds_isBandR2_magMulOp
import Theorems.Thm_BookProof_HermiteBandHigher_IsBandR_add
import Theorems.Thm_BookProof_HermiteBandHigher_IsBandR_comp
import Theorems.Thm_BookProof_HermiteBandHigher_IsBandR_le
import Theorems.Thm_BookProof_HermiteBandHigher_IsBandR_monoR
import Theorems.Thm_BookProof_HermiteBandHigher_IsBandR_smul
import Theorems.Thm_BookProof_HermiteBandHigher_IsBandR_sum
import Theorems.Thm_BookProof_HermiteRelative_momPoly_eq_ymMomOp
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterHermiteProductBasis
import Definitions.Def_ChapterHermiteBandCalculus
import Definitions.Def_ChapterQuadraticFockEsa
import Definitions.Def_ChapterFockSecondQuantization
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Definitions.Def_ChapterHermiteGalerkinFriedrichs
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterFullQuadraticEsa
import Definitions.Def_ChapterYangMillsFriedrichs
import Definitions.Def_ChapterYangMillsAbelianFockEsa
import Definitions.Def_ChapterHermiteRelativeBound
import Definitions.Def_ChapterF7
import Definitions.Def_ChapterHermiteBandCalculusHigher
import Definitions.Def_ChapterNavierStokesDifferentialL2
import Definitions.Def_ChapterSirkFinitePrecision
import Definitions.Def_ChapterYangMillsAbelianEsa
import Definitions.Def_ChapterYangMillsHermite
open BookProof.YangMillsBandBounds




noncomputable section

open MvPolynomial BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.HermiteBand BookProof.HermiteBandHigher BookProof.QuadFockEsa
open BookProof.FockSecondQuantization BookProof.NavierStokesFlow
open BookProof.HermiteGalerkin BookProof.FarisLavine
open BookProof.YangMillsHermite BookProof.FullQuadratic BookProof.YangMillsAbelianEsa
open BookProof.YangMillsFriedrichs BookProof.YmAbelianFock
open BookProof.NavierStokesFlow.DifferentialL2 BookProof.HermiteRelative
open BookProof.ChapterF7
open BookProof.HermiteBandHigher
open BookProof.NavierStokesFlow.DifferentialL2
open BookProof.SirkFinitePrecision
open BookProof.SirkFinitePrecision.CertInterval
open BookProof.YangMillsAbelianEsa
open BookProof.YangMillsHermite

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
