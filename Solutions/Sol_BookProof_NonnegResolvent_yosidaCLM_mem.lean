-- Generated from ChapterNonnegResolvent.lean — solution of BookProof.NonnegResolvent.yosidaCLM_mem
import Mathlib
import Definitions.Def_ChapterNonnegResolvent
import Theorems.Thm_BookProof_NonnegResolvent_yosidaCLM_apply
import Theorems.Thm_BookProof_NonnegSquareRoot_invCLMAt_mem
open BookProof.NonnegResolvent




open BookProof.ClosureUniqueness BookProof.PositiveSquareRoot BookProof.NonnegSquareRoot
open scoped ComplexOrder

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {T : Submodule ℂ (F × F)} {a b : ℝ}

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {T : Submodule ℂ (F × F)} {a b : ℝ}

set_option maxHeartbeats 1000000 in
theorem solution (hT : IsNonnegSelfAdjoint T) (ha : 0 < a) (h : F) :
    ((a : ℂ) • invCLMAt hT ha h, yosidaCLM hT ha h) ∈ T := by

  have hmem := T.smul_mem (a : ℂ) (invCLMAt_mem hT ha h)
  rw [Prod.smul_mk] at hmem
  rw [yosidaCLM_apply]
  exact hmem
