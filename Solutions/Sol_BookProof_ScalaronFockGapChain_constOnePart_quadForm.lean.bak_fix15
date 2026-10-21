-- Generated from ChapterScalaronFockGapChain.lean — solution of BookProof.ScalaronFockGapChain.constOnePart_quadForm
import Mathlib
import Definitions.Def_ChapterScalaronFockGapChain
open BookProof.ScalaronFockGapChain



noncomputable section


open BookProof.FockSecondQuantization BookProof.FockOneParticleGap
open BookProof.FockNumberPreservingGap BookProof.FockFieldPerturbation
open BookProof.FockCubicQuarticStability BookProof.FockCubicUnbounded
open BookProof.FockInteractionStability
open BookProof.FarisLavine BookProof.YangMillsFriedrichs BookProof.HermiteGalerkin
open BookProof.HermiteCore

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

set_option maxHeartbeats 1000000 in
theorem solution (b : HilbertBasis ℕ ℂ F) (m : ℝ)
    (x : finiteModeDomain b) :
    quadForm ((finiteModeDomain b).subtype.comp (constOnePart b m)) x = m * ‖(x : F)‖ ^ 2 := by

  simp only [quadForm, constOnePart, LinearMap.coe_comp, Function.comp_apply,
    Submodule.subtype_apply, LinearMap.smul_apply, LinearMap.id_apply, Submodule.coe_smul,
    inner_smul_right, Complex.re_ofReal_mul, inner_self_eq_norm_sq_to_K]
  norm_cast
