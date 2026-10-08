-- Generated from ChapterA1c.lean — theorem BookProof.ChapterA.not_isCPseudoreal_and_isCComplex
import Mathlib
import Definitions.Def_ChapterA1c
import Definitions.Def_ChapterA
open BookProof.ChapterA
open BookProof.ChapterA


open scoped ComplexConjugate InnerProductSpace RealInnerProductSpace

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]

theorem BookProof.ChapterA.not_isCPseudoreal_and_isCComplex (M : System ℂ V) :
    ¬ (IsCPseudoreal M ∧ IsCComplex M) := by sorry
