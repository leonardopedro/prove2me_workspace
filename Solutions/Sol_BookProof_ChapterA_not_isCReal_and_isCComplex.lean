-- Generated from ChapterA1c.lean — solution of BookProof.ChapterA.not_isCReal_and_isCComplex
import Mathlib
import Definitions.Def_ChapterA1c
import Theorems.Thm_BookProof_ChapterA_IsCReal_hasCommutingAntiUnitary
open BookProof.ChapterA



open scoped ComplexConjugate InnerProductSpace RealInnerProductSpace

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]

set_option maxHeartbeats 1000000 in
theorem solution (M : System ℂ V) :
    ¬ (IsCReal M ∧ IsCComplex M) := fun h => h.2 h.1.hasCommutingAntiUnitary
