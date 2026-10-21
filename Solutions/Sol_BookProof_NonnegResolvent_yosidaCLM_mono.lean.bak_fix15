-- Generated from ChapterNonnegResolvent.lean — solution of BookProof.NonnegResolvent.yosidaCLM_mono
import Mathlib
import Definitions.Def_ChapterNonnegResolvent
import Theorems.Thm_BookProof_NonnegResolvent_invCLMAt_comm
import Theorems.Thm_BookProof_NonnegResolvent_smul_invCLMAt_le_one
import Theorems.Thm_BookProof_NonnegResolvent_smul_nonneg_of_nonneg
import Theorems.Thm_BookProof_NonnegResolvent_yosidaCLM_sub
open BookProof.NonnegResolvent




open BookProof.ClosureUniqueness BookProof.PositiveSquareRoot BookProof.NonnegSquareRoot
open scoped ComplexOrder

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {T : Submodule ℂ (F × F)} {a b : ℝ}

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {T : Submodule ℂ (F × F)} {a b : ℝ}

set_option maxHeartbeats 1000000 in
theorem solution (hT : IsNonnegSelfAdjoint T) (ha : 0 < a) (hb : 0 < b) (hab : a ≤ b) :
    yosidaCLM hT ha ≤ yosidaCLM hT hb := by

  rw [← sub_nonneg, yosidaCLM_sub hT ha hb]
  have hA : (0 : F →L[ℂ] F) ≤ 1 - (a : ℂ) • invCLMAt hT ha :=
    sub_nonneg.2 (smul_invCLMAt_le_one hT ha)
  have hB : (0 : F →L[ℂ] F) ≤ 1 - (b : ℂ) • invCLMAt hT hb :=
    sub_nonneg.2 (smul_invCLMAt_le_one hT hb)
  have hcomm : (1 - (a : ℂ) • invCLMAt hT ha) * (1 - (b : ℂ) • invCLMAt hT hb)
      = (1 - (b : ℂ) • invCLMAt hT hb) * (1 - (a : ℂ) • invCLMAt hT ha) := by
    ext h
    simp only [ContinuousLinearMap.mul_apply, ContinuousLinearMap.sub_apply,
      ContinuousLinearMap.smul_apply, ContinuousLinearMap.one_apply, map_sub, map_smul]
    rw [invCLMAt_comm hT ha hb h]
    module
  have hprod : (0 : F →L[ℂ] F) ≤
      (1 - (a : ℂ) • invCLMAt hT ha) * (1 - (b : ℂ) • invCLMAt hT hb) :=
    (commute_iff_mul_nonneg hA hB).1 hcomm
  have hcast : ((b : ℂ) - (a : ℂ)) = ((b - a : ℝ) : ℂ) := by push_cast; ring
  rw [hcast]
  exact smul_nonneg_of_nonneg (by linarith) hprod
