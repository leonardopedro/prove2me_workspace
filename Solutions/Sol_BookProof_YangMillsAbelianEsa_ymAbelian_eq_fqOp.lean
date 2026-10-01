-- Generated from ChapterYangMillsAbelianEsa.lean — solution of BookProof.YangMillsAbelianEsa.ymAbelian_eq_fqOp
import Mathlib
import Definitions.Def_ChapterYangMillsAbelianEsa
import Theorems.Thm_BookProof_YangMillsAbelianEsa_ymAbelianPoly_eq_fqPoly
import Theorems.Thm_BookProof_YangMillsAbelianEsa_coreRepPoly_equiv
import Theorems.Thm_BookProof_YangMillsAbelianEsa_pgLp_ymAbelianPoly
import Theorems.Thm_BookProof_NavierStokesFlow_DifferentialL2_coreOp_coe
import Theorems.Thm_BookProof_YangMillsFriedrichs_weylOp_apply
import Theorems.Thm_BookProof_YangMillsHermite_CoreRep_coe_op
import Theorems.Thm_BookProof_YangMillsHermite_CoreRep_op_apply
open BookProof.YangMillsAbelianEsa




open Finset MvPolynomial
open BookProof.HermiteProductCore BookProof.YangMillsHermite
open BookProof.FarisLavine
open BookProof.NavierStokesFlow.DifferentialL2
open BookProof.HermiteRelative
open BookProof.FullQuadratic
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent
open BookProof.HashimotoShiftInvert BookProof.HermiteGalerkin BookProof.YangMillsFriedrichs

noncomputable section

set_option maxHeartbeats 1000000 in
set_option maxHeartbeats 4000000 in
-- the `L²` coercions of the Gauss–polynomial core make these defeq checks expensive
theorem solution :
    ymHamiltonian (coreRepPoly 99) 0 = fqOp ymFqP ymFqQ 0 0 0 := by

  refine LinearMap.ext fun x => ?_
  obtain ⟨p, rfl⟩ := (coreEquiv (d := 99)).surjective x
  have hx : ((coreRepPoly 99).equiv.symm (coreEquiv p) : MvPolynomial (Fin 99) ℂ) = p := by
    rw [← coreRepPoly_equiv p, LinearEquiv.symm_apply_apply]
  have hmom : ∀ m : Fin 24,
      ((piOps (coreRepPoly 99) m (piOps (coreRepPoly 99) m (coreEquiv p))
        : polyGaussCore (d := 99)) : L2d 99)
        = pgLp (YangMillsHermite.momOp (ymMomIdx m)
            (YangMillsHermite.momOp (ymMomIdx m) p)) := by
    intro m
    rw [piOps, CoreRep.coe_op, CoreRep.op_apply, LinearEquiv.symm_apply_apply, hx]
    rfl
  have hmag : ∀ m : Fin 24,
      ((magOps (coreRepPoly 99) 0 m (magOps (coreRepPoly 99) 0 m (coreEquiv p))
        : polyGaussCore (d := 99)) : L2d 99)
        = pgLp (mulOp (magPoly 0 (decodeSpace m) (decodeColor m))
            (mulOp (magPoly 0 (decodeSpace m) (decodeColor m)) p)) := by
    intro m
    rw [magOps, CoreRep.coe_op, CoreRep.op_apply, LinearEquiv.symm_apply_apply, hx]
  rw [ymHamiltonian, YangMillsFriedrichs.weylOp_apply]
  simp only [hmom, hmag]
  rw [fqOp, LinearMap.comp_apply, Submodule.subtype_apply, coreOp_coe,
    ← ymAbelianPoly_eq_fqPoly, pgLp_ymAbelianPoly]
