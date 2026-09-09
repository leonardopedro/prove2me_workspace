-- Generated from ChapterYangMillsBandBounds.lean — solution of BookProof.YangMillsBandBounds.isBandDeg2_magMulOp
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
theorem solution (fabc : Fin 8 → Fin 8 → Fin 8 → ℝ) (i : Fin 3) (a : Fin 8) :
    IsBandDeg 2 (mulOp (magPoly fabc i a)) := (isBandR2_magMulOp fabc i a).isBandDeg
