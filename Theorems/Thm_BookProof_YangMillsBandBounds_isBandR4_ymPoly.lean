-- Generated from ChapterYangMillsBandBounds.lean — theorem BookProof.YangMillsBandBounds.isBandR4_ymPoly
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

theorem BookProof.YangMillsBandBounds.isBandR4_ymPoly (fabc : Fin 8 → Fin 8 → Fin 8 → ℝ) : IsBandR 4 4 (ymPoly fabc) := by sorry
