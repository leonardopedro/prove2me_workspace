-- Generated from ChapterA1c.lean — theorem BookProof.ChapterA.not_isCReal_and_isCPseudoreal
import Mathlib
import Definitions.Def_ChapterA1c
import Definitions.Def_ChapterA
open BookProof.ChapterA
open BookProof.ChapterA


open scoped ComplexConjugate InnerProductSpace RealInnerProductSpace

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]

theorem BookProof.ChapterA.not_isCReal_and_isCPseudoreal (M : System ℂ V) :
    ¬ (IsCReal M ∧ IsCPseudoreal M) := by sorry
