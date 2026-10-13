-- Generated from ChapterYangMillsBandBounds.lean — solution of BookProof.YangMillsBandBounds.isBandR2_magMulOp
import Mathlib
import Definitions.Def_ChapterYangMillsBandBounds
import Theorems.Thm_BookProof_HermiteBandHigher_IsBandR_add
import Theorems.Thm_BookProof_HermiteBandHigher_IsBandR_comp
import Theorems.Thm_BookProof_HermiteBandHigher_IsBandR_le
import Theorems.Thm_BookProof_HermiteBandHigher_IsBandR_monoR
import Theorems.Thm_BookProof_HermiteBandHigher_IsBandR_smul
import Theorems.Thm_BookProof_HermiteBandHigher_IsBandR_sum
import Theorems.Thm_BookProof_HermiteBandHigher_mulOp_eq_mulXPoly
import Theorems.Thm_BookProof_HermiteBandHigher_mulOp_mul
import Theorems.Thm_BookProof_HermiteBandHigher_mulOp_smul
import Theorems.Thm_BookProof_HermiteBandHigher_mulOp_sum
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterHermiteProductBasis
import Definitions.Def_ChapterHermiteBandCalculus
import Definitions.Def_ChapterQuadraticFockEsa
import Definitions.Def_ChapterFockSecondQuantization
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Definitions.Def_ChapterHermiteGalerkinFriedrichs
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterFullQuadraticEsa
import Definitions.Def_ChapterYangMillsAbelianEsa
import Definitions.Def_ChapterYangMillsFriedrichs
import Definitions.Def_ChapterYangMillsAbelianFockEsa
import Definitions.Def_ChapterHermiteRelativeBound
import Definitions.Def_ChapterF7
import Definitions.Def_ChapterHermiteBandCalculusHigher
import Definitions.Def_ChapterNavierStokesDifferentialL2
import Definitions.Def_ChapterSirkFinitePrecision
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
open BookProof.YangMillsHermite

set_option maxHeartbeats 1000000 in
theorem solution (fabc : Fin 8 → Fin 8 → Fin 8 → ℝ) (i : Fin 3) (a : Fin 8) :
    IsBandR 2 2 (mulOp (magPoly fabc i a)) := by

  rw [magPoly, mulOp_sum]
  refine IsBandR.sum _ _ fun j _ => ?_
  rw [mulOp_sum]
  refine IsBandR.sum _ _ fun k _ => ?_
  rw [mulOp_smul]
  refine IsBandR.smul _ ?_
  rw [mulOp_add_prime]
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
