-- Generated from ChapterNonnegSquareRoot.lean — solution of BookProof.NonnegSquareRoot.invCLMAt_mem
import Mathlib
import Definitions.Def_ChapterNonnegSquareRoot
import Theorems.Thm_BookProof_NonnegSquareRoot_invCLMAt_apply
import Theorems.Thm_BookProof_PositiveSquareRoot_invCLM_mem
open BookProof.NonnegSquareRoot




open BookProof.FarisLavine BookProof.EsaClosure BookProof.ClosureUniqueness
open BookProof.FriedrichsSquare BookProof.VonNeumannCore
open BookProof.PositiveSquareRoot
open scoped ComplexOrder

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {T S : Submodule ℂ (F × F)}

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {T S : Submodule ℂ (F × F)}
variable {a : ℝ}

set_option maxHeartbeats 1000000 in
theorem solution (hT : IsNonnegSelfAdjoint T) (ha : 0 < a) (h : F) :
    (invCLMAt hT ha h, h - (a : ℂ) • invCLMAt hT ha h) ∈ T := by

  have ha' : (a : ℂ) ≠ 0 := by exact_mod_cast ha.ne'
  have hinv : ((a⁻¹ : ℝ) : ℂ) ≠ 0 := by
    simpa using (inv_ne_zero ha')
  have hmem := invCLM_mem (isNonnegSelfAdjoint_invSmulRel hT ha) (((a : ℂ))⁻¹ • h)
  rw [mem_smulRel_iff (inv_ne_zero ha.ne')] at hmem
  have hcast : (((a⁻¹ : ℝ) : ℂ))⁻¹ = (a : ℂ) := by
    push_cast
    rw [inv_inv]
  rw [hcast] at hmem
  rw [invCLMAt_apply]
  convert hmem using 2
  rw [smul_sub, smul_smul, mul_inv_cancel₀ ha', one_smul]
