-- Generated from ChapterYangMillsAbelianFockEsa.lean — solution of BookProof.YmAbelianFock.ymAbelianHermOp_eq
import Mathlib
import Definitions.Def_ChapterYangMillsAbelianFockEsa
import Theorems.Thm_BookProof_YmAbelianFock_coreRep_op_comp
import Theorems.Thm_BookProof_YmAbelianFock_coreRep_op_add
import Theorems.Thm_BookProof_YmAbelianFock_coreRep_op_smul
import Theorems.Thm_BookProof_YmAbelianFock_coreRep_op_sum
open BookProof.YmAbelianFock




open MvPolynomial BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.HermiteBand BookProof.GradedBandSchur BookProof.QuadFockEsa
open BookProof.FockSecondQuantization BookProof.NavierStokesFlow
open BookProof.HermiteGalerkin BookProof.FarisLavine
open BookProof.YangMillsHermite BookProof.FullQuadratic BookProof.YangMillsAbelianEsa
open BookProof.YangMillsFriedrichs
open Filter Topology
open BookProof.ChapterStoneResolvent BookProof.EsaClosure BookProof.StoneBridge
open BookProof.HashimotoShiftInvert BookProof.SirkSingleTime
open BookProof.FiniteSectionSingleTime BookProof.QgTimeIndependent

noncomputable section

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (e : ℕ ≃ (Fin 99 →₀ ℕ)) :
    ymAbelianHermOp e = (coreRepHerm e).op ymAbelianPoly := by

  have h1 : (∑ m : Fin 24, (piOps (coreRepHerm e) m).comp (piOps (coreRepHerm e) m))
      = ∑ m : Fin 24, (coreRepHerm e).op
          ((YangMillsHermite.momOp (ymMomIdx m)).comp (YangMillsHermite.momOp (ymMomIdx m))) :=
    Finset.sum_congr rfl fun m _ => by rw [coreRep_op_comp]; rfl
  have h2 : (∑ m : Fin 24, (magOps (coreRepHerm e) 0 m).comp (magOps (coreRepHerm e) 0 m))
      = ∑ m : Fin 24, (coreRepHerm e).op
          ((mulOp (magPoly 0 (decodeSpace m) (decodeColor m))).comp
            (mulOp (magPoly 0 (decodeSpace m) (decodeColor m)))) :=
    Finset.sum_congr rfl fun m _ => by rw [coreRep_op_comp]; rfl
  rw [ymAbelianHermOp, weylOpDom, ymAbelianPoly, coreRep_op_smul, coreRep_op_add,
    coreRep_op_sum, coreRep_op_sum, h1, h2]
