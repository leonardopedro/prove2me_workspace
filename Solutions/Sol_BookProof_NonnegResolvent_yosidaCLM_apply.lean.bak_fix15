-- Generated from ChapterNonnegResolvent.lean — solution of BookProof.NonnegResolvent.yosidaCLM_apply
import Mathlib
import Definitions.Def_ChapterNonnegResolvent
open BookProof.NonnegResolvent




open BookProof.ClosureUniqueness BookProof.PositiveSquareRoot BookProof.NonnegSquareRoot
open scoped ComplexOrder

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {T : Submodule ℂ (F × F)} {a b : ℝ}

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {T : Submodule ℂ (F × F)} {a b : ℝ}

set_option maxHeartbeats 1000000 in
theorem solution (hT : IsNonnegSelfAdjoint T) (ha : 0 < a) (h : F) :
    yosidaCLM hT ha h = (a : ℂ) • (h - (a : ℂ) • invCLMAt hT ha h) := by

  simp [yosidaCLM]
