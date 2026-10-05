-- Generated from ChapterA1c.lean — solution of BookProof.ChapterA.not_isCReal_and_isCPseudoreal
import Mathlib
import Definitions.Def_ChapterA1c
open BookProof.ChapterA



open scoped ComplexConjugate InnerProductSpace RealInnerProductSpace

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]

set_option maxHeartbeats 1000000 in
theorem solution (M : System ℂ V) :
    ¬ (IsCReal M ∧ IsCPseudoreal M) := fun h => h.2.1 h.1
