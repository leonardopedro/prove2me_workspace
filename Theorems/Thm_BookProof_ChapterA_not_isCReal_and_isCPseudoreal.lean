-- Generated from ChapterA1c.lean — theorem BookProof.ChapterA.not_isCReal_and_isCPseudoreal
import Mathlib
import Definitions.Def_ChapterA1c
import Definitions.Def_ChapterA
open BookProof.ChapterA
open BookProof.ChapterA

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]


open scoped ComplexConjugate InnerProductSpace RealInnerProductSpace

theorem BookProof.ChapterA.not_isCReal_and_isCPseudoreal (M : System ℂ V) :
    ¬ (IsCReal M ∧ IsCPseudoreal M) := by sorry
