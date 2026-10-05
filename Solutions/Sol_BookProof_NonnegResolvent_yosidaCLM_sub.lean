-- Generated from ChapterNonnegResolvent.lean — solution of BookProof.NonnegResolvent.yosidaCLM_sub
import Mathlib
import Definitions.Def_ChapterNonnegResolvent
import Theorems.Thm_BookProof_NonnegResolvent_invCLMAt_sub
open BookProof.NonnegResolvent




open BookProof.ClosureUniqueness BookProof.PositiveSquareRoot BookProof.NonnegSquareRoot
open scoped ComplexOrder

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {T : Submodule ℂ (F × F)} {a b : ℝ}

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {T : Submodule ℂ (F × F)} {a b : ℝ}

set_option maxHeartbeats 1000000 in
theorem solution (hT : IsNonnegSelfAdjoint T) (ha : 0 < a) (hb : 0 < b) :
    yosidaCLM hT hb - yosidaCLM hT ha
      = ((b : ℂ) - (a : ℂ)) •
        ((1 - (a : ℂ) • invCLMAt hT ha) * (1 - (b : ℂ) • invCLMAt hT hb)) := by

  ext h
  have hres : invCLMAt hT ha h - invCLMAt hT hb h
      = ((b : ℂ) - (a : ℂ)) • invCLMAt hT ha (invCLMAt hT hb h) := invCLMAt_sub hT ha hb h
  simp only [yosidaCLM, ContinuousLinearMap.sub_apply, ContinuousLinearMap.smul_apply,
    ContinuousLinearMap.mul_apply, ContinuousLinearMap.one_apply, map_sub, map_smul]
  linear_combination (norm := module) ((a : ℂ) * (b : ℂ)) • hres
