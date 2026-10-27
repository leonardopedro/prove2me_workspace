-- Generated from ChapterScalaronFockGapChain.lean — solution of BookProof.ScalaronFockGapChain.const_isPosCol_shiftCol
import Mathlib
import Definitions.Def_ChapterScalaronFockGapChain
import Theorems.Thm_BookProof_ScalaronFockGapChain_constOnePart_quadForm
import Theorems.Thm_BookProof_FockNumberPreservingGap_shiftCol_opCol
import Theorems.Thm_BookProof_FockSecondQuantization_isPosCol_opCol
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
theorem solution (b : HilbertBasis ℕ ℂ F) (m : ℝ) :
    IsPosCol (shiftCol (opCol b (constOnePart b m)) m) := by

  have hpos : ∀ x : finiteModeDomain b,
      0 ≤ quadForm ((finiteModeDomain b).subtype.comp
        (constOnePart b m - ((m : ℝ) : ℂ) • LinearMap.id)) x := by
    intro x
    have hval : quadForm ((finiteModeDomain b).subtype.comp
        (constOnePart b m - ((m : ℝ) : ℂ) • LinearMap.id)) x
        = quadForm ((finiteModeDomain b).subtype.comp (constOnePart b m)) x
          - m * ‖(x : F)‖ ^ 2 := by
      simp only [quadForm, LinearMap.coe_comp, Function.comp_apply, Submodule.subtype_apply,
        LinearMap.sub_apply, LinearMap.smul_apply, LinearMap.id_apply, Submodule.coe_sub,
        Submodule.coe_smul, inner_sub_right, inner_smul_right, Complex.sub_re,
        Complex.re_ofReal_mul, inner_self_eq_norm_sq_to_K]
      norm_cast
    rw [hval, constOnePart_quadForm]
    linarith
  rw [shiftCol_opCol]
  exact isPosCol_opCol hpos
