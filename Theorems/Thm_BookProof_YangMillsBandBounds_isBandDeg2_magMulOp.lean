-- Generated from ChapterYangMillsBandBounds.lean — theorem BookProof.YangMillsBandBounds.isBandDeg2_magMulOp
import Mathlib
import Definitions.Def_ChapterYangMillsBandBounds
open BookProof.YangMillsBandBounds












noncomputable section

open MvPolynomial BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.HermiteBand BookProof.HermiteBandHigher BookProof.QuadFockEsa
open BookProof.FockSecondQuantization BookProof.NavierStokesFlow
open BookProof.HermiteGalerkin BookProof.FarisLavine
open BookProof.YangMillsHermite BookProof.FullQuadratic BookProof.YangMillsAbelianEsa
open BookProof.YangMillsFriedrichs BookProof.YmAbelianFock
open BookProof.NavierStokesFlow.DifferentialL2 BookProof.HermiteRelative

theorem BookProof.YangMillsBandBounds.isBandDeg2_magMulOp (fabc : Fin 8 → Fin 8 → Fin 8 → ℝ) (i : Fin 3) (a : Fin 8) :
    IsBandDeg 2 (mulOp (magPoly fabc i a)) := by sorry
