-- Generated from ChapterNonnegSquareRoot.lean — solution of BookProof.NonnegSquareRoot.invCLMAt_eq_of_mem
import Mathlib
import Definitions.Def_ChapterNonnegSquareRoot
import Theorems.Thm_BookProof_NonnegSquareRoot_invCLMAt_apply
import Theorems.Thm_BookProof_PositiveSquareRoot_invCLM_eq_of_mem
open BookProof.NonnegSquareRoot




open BookProof.FarisLavine BookProof.EsaClosure BookProof.ClosureUniqueness
open BookProof.FriedrichsSquare BookProof.VonNeumannCore BookProof.UnboundedPolar
open BookProof.PositiveSquareRoot
open scoped ComplexOrder

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {T S : Submodule ℂ (F × F)}

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {T S : Submodule ℂ (F × F)}
variable {a : ℝ}

set_option maxHeartbeats 1000000 in
theorem solution (hT : IsNonnegSelfAdjoint T) (ha : 0 < a) {x h : F}
    (hx : (x, h - (a : ℂ) • x) ∈ T) : invCLMAt hT ha h = x := by

  have ha' : (a : ℂ) ≠ 0 := by exact_mod_cast ha.ne'
  have hmem : (x, ((a : ℂ))⁻¹ • h - x) ∈ smulRel a⁻¹ T := by
    rw [mem_smulRel_iff (inv_ne_zero ha.ne')]
    have hcast : (((a⁻¹ : ℝ) : ℂ))⁻¹ = (a : ℂ) := by
      push_cast
      rw [inv_inv]
    rw [hcast]
    convert hx using 2
    rw [smul_sub, smul_smul, mul_inv_cancel₀ ha', one_smul]
  rw [invCLMAt_apply]
  exact invCLM_eq_of_mem _ hmem
