-- Generated from ChapterNsLinearKoopmanEsa.lean — solution of BookProof.NsLinearKoopmanEsa.subtype_comp_coreRepPoly_op
import Mathlib
import Definitions.Def_ChapterNsLinearKoopmanEsa
import Theorems.Thm_BookProof_NsLinearKoopmanEsa_coreRepPoly_equiv_prime
import Theorems.Thm_BookProof_NavierStokesFlow_DifferentialL2_coreOp_coe
import Theorems.Thm_BookProof_YangMillsHermite_CoreRep_coe_op
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterHermiteRelativeBound
import Definitions.Def_ChapterFullQuadraticEsa
import Definitions.Def_ChapterA4
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterSirkTrotterKato
import Definitions.Def_ChapterFockSecondQuantization
import Definitions.Def_ChapterQuadraticFockEsa
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterNavierStokesDifferentialL2
import Definitions.Def_ChapterYangMillsHermite
open BookProof.NsLinearKoopmanEsa




open MvPolynomial
open BookProof.HermiteProductCore BookProof.YangMillsHermite
open BookProof.FarisLavine
open BookProof.NavierStokesFlow.DifferentialL2
open BookProof.HermiteRelative
open BookProof.FullQuadratic
open BookProof.NsKoopman
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent
open BookProof.FockSecondQuantization BookProof.QuadFockEsa
open BookProof.HermiteProductCore
open BookProof.YangMillsHermite

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
    rw [← coreRepPoly_equiv_prime p, LinearEquiv.symm_apply_apply]
  rw [LinearMap.comp_apply, Submodule.subtype_apply, CoreRep.coe_op, hx, LinearMap.comp_apply,
    Submodule.subtype_apply, coreOp_coe]
