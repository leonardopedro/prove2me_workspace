-- Generated from ChapterYangMillsBandBounds.lean — solution of BookProof.YangMillsBandBounds.isBandR2_magMulOp
import Mathlib
import Definitions.Def_ChapterYangMillsBandBounds
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
theorem solution (fabc : Fin 8 → Fin 8 → Fin 8 → ℝ) (i : Fin 3) (a : Fin 8) :
    IsBandR 2 2 (mulOp (magPoly fabc i a)) := by

  rw [magPoly, mulOp_sum]
  refine IsBandR.sum _ _ fun j _ => ?_
  rw [mulOp_sum]
  refine IsBandR.sum _ _ fun k _ => ?_
  rw [mulOp_smul]
  refine IsBandR.smul _ ?_
  rw [mulOp_add']
  refine IsBandR.add ?_ ?_
  · rw [mulOp_eq_mulXPoly]
    exact ((isBandR1_mulXPoly _).le (by norm_num)).monoR (by norm_num)
  · rw [mulOp_sum]
    refine IsBandR.sum _ _ fun b _ => ?_
    rw [mulOp_sum]
    refine IsBandR.sum _ _ fun c _ => ?_
    rw [mulOp_smul]
    refine IsBandR.smul _ ?_
    rw [mulOp_mul, mulOp_eq_mulXPoly, mulOp_eq_mulXPoly]
    exact (isBandR1_mulXPoly _).comp (isBandR1_mulXPoly _)
