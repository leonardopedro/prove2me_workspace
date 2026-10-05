-- Generated from ChapterNsLinearKoopmanEsa.lean — solution of BookProof.NsLinearKoopmanEsa.subtype_comp_coreRepPoly_op
import Mathlib
import Definitions.Def_ChapterNsLinearKoopmanEsa
import Theorems.Thm_BookProof_NsLinearKoopmanEsa_coreRepPoly_equiv'
import Theorems.Thm_BookProof_NavierStokesFlow_DifferentialL2_coreOp_coe
import Theorems.Thm_BookProof_YangMillsHermite_CoreRep_coe_op
open BookProof.NsLinearKoopmanEsa




open MvPolynomial
open BookProof.HermiteProductCore BookProof.YangMillsHermite
open BookProof.FarisLavine
open BookProof.NavierStokesFlow.DifferentialL2
open BookProof.HermiteRelative
open BookProof.FullQuadratic
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent
open BookProof.FockSecondQuantization BookProof.QuadFockEsa

noncomputable section

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (T : Module.End ℂ (MvPolynomial (Fin d) ℂ)) :
    (polyGaussCore (d := d)).subtype.comp ((coreRepPoly d).op T)
      = (polyGaussCore (d := d)).subtype ∘ₗ coreOp T := by

  refine LinearMap.ext fun x => ?_
  obtain ⟨p, rfl⟩ := (coreEquiv (d := d)).surjective x
  have hx : ((coreRepPoly d).equiv.symm (coreEquiv p) : MvPolynomial (Fin d) ℂ) = p := by
    rw [← coreRepPoly_equiv' p, LinearEquiv.symm_apply_apply]
  rw [LinearMap.comp_apply, Submodule.subtype_apply, CoreRep.coe_op, hx, LinearMap.comp_apply,
    Submodule.subtype_apply, coreOp_coe]
