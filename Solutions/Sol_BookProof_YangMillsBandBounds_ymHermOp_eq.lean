-- Generated from ChapterYangMillsBandBounds.lean — solution of BookProof.YangMillsBandBounds.ymHermOp_eq
import Mathlib
import Definitions.Def_ChapterYangMillsBandBounds
import Theorems.Thm_BookProof_YmAbelianFock_coreRep_op_add
import Theorems.Thm_BookProof_YmAbelianFock_coreRep_op_comp
import Theorems.Thm_BookProof_YmAbelianFock_coreRep_op_smul
import Theorems.Thm_BookProof_YmAbelianFock_coreRep_op_sum
import Definitions.Def_ChapterHermiteProductBasis
import Definitions.Def_ChapterHermiteBandCalculus
import Definitions.Def_ChapterHermiteBandCalculusHigher
import Definitions.Def_ChapterFockSecondQuantization
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterFullQuadraticEsa
import Definitions.Def_ChapterYangMillsAbelianFockEsa
import Definitions.Def_ChapterHermiteRelativeBound
import Definitions.Def_ChapterF7
import Definitions.Def_ChapterHermiteGalerkinFriedrichs
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterNavierStokesDifferentialL2
import Definitions.Def_ChapterQuadraticFockEsa
import Definitions.Def_ChapterYangMillsAbelianEsa
import Definitions.Def_ChapterYangMillsFriedrichs
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
open BookProof.HermiteGalerkin
open BookProof.HermiteProductCore
open BookProof.NavierStokesFlow.DifferentialL2
open BookProof.QuadFockEsa
open BookProof.YangMillsAbelianEsa
open BookProof.YangMillsFriedrichs
open BookProof.YangMillsHermite

set_option maxHeartbeats 1000000 in
theorem solution (e : ℕ ≃ (Fin 99 →₀ ℕ)) (fabc : Fin 8 → Fin 8 → Fin 8 → ℝ) :
    ymHermOp e fabc = (coreRepHerm e).op (ymPoly fabc) := by

  have h1 : (∑ m : Fin 24, (piOps (coreRepHerm e) m).comp (piOps (coreRepHerm e) m))
      = ∑ m : Fin 24, (coreRepHerm e).op
          ((YangMillsHermite.momOp (ymMomIdx m)).comp (YangMillsHermite.momOp (ymMomIdx m))) :=
    Finset.sum_congr rfl fun m _ => by rw [coreRep_op_comp]; rfl
  have h2 : (∑ m : Fin 24, (magOps (coreRepHerm e) fabc m).comp (magOps (coreRepHerm e) fabc m))
      = ∑ m : Fin 24, (coreRepHerm e).op
          ((mulOp (magPoly fabc (decodeSpace m) (decodeColor m))).comp
            (mulOp (magPoly fabc (decodeSpace m) (decodeColor m)))) :=
    Finset.sum_congr rfl fun m _ => by rw [coreRep_op_comp]; rfl
  rw [ymHermOp, weylOpDom, ymPoly, coreRep_op_smul, coreRep_op_add,
    coreRep_op_sum, coreRep_op_sum, h1, h2]
