-- Generated from ChapterA1h.lean — solution of BookProof.ChapterA.IsRComplexType.not_isRReal
import Mathlib
import Definitions.Def_ChapterA1h
import Theorems.Thm_BookProof_ChapterA_IsRReal_not_hasCommutingRImaginary
open BookProof.ChapterA



open scoped ComplexConjugate InnerProductSpace RealInnerProductSpace


open BookProof.Complexification

variable {W : Type*} [NormedAddCommGroup W] [InnerProductSpace ℝ W] [CompleteSpace W]

variable {W : Type*} [NormedAddCommGroup W] [InnerProductSpace ℝ W] [CompleteSpace W]

set_option maxHeartbeats 1000000 in
theorem solution [Nontrivial W] {M : System ℝ W}
    (h : IsRComplexType M) : ¬ IsRReal M := fun hRReal => hRReal.not_hasCommutingRImaginary h.1
