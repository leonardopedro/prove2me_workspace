-- Generated from ChapterNonnegResolvent.lean — solution of BookProof.NonnegResolvent.re_inner_yosidaCLM_le
import Mathlib
import Definitions.Def_ChapterNonnegResolvent
import Theorems.Thm_BookProof_NonnegResolvent_inner_invCLMAt_left
import Theorems.Thm_BookProof_NonnegResolvent_invCLMAt_nonneg
import Theorems.Thm_BookProof_NonnegResolvent_smul_invCLMAt_sub_of_mem
import Theorems.Thm_BookProof_NonnegResolvent_yosidaCLM_of_mem
open BookProof.NonnegResolvent




open BookProof.ClosureUniqueness BookProof.PositiveSquareRoot BookProof.NonnegSquareRoot
open scoped ComplexOrder

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {T : Submodule ℂ (F × F)} {a b : ℝ}

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {T : Submodule ℂ (F × F)} {a b : ℝ}

set_option maxHeartbeats 1000000 in
theorem solution (hT : IsNonnegSelfAdjoint T) (ha : 0 < a) {h k : F}
    (hk : (h, k) ∈ T) :
    (inner ℂ h (yosidaCLM hT ha h) : ℂ).re ≤ (inner ℂ h k : ℂ).re := by

  have hsub : h - (a : ℂ) • invCLMAt hT ha h = invCLMAt hT ha k := by
    rw [← neg_sub, smul_invCLMAt_sub_of_mem hT ha hk, neg_neg]
  have hy : (inner ℂ h (yosidaCLM hT ha h) : ℂ) = inner ℂ ((a : ℂ) • invCLMAt hT ha h) k := by
    rw [yosidaCLM_of_mem hT ha hk, inner_smul_right, inner_smul_left, Complex.conj_ofReal,
      inner_invCLMAt_left hT ha h k]
  have hsplit : (inner ℂ h k : ℂ)
      = inner ℂ ((a : ℂ) • invCLMAt hT ha h) k + inner ℂ (invCLMAt hT ha k) k := by
    rw [← inner_add_left, ← hsub]
    congr 1
    abel
  have hpos : 0 ≤ (inner ℂ (invCLMAt hT ha k) k : ℂ).re := by
    have := (ContinuousLinearMap.isPositive_iff_complex _).1
      ((ContinuousLinearMap.nonneg_iff_isPositive _).1 (invCLMAt_nonneg hT ha)) k
    exact this.2
  rw [hy, hsplit, Complex.add_re]
  linarith
