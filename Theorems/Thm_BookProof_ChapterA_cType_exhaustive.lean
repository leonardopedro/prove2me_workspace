-- Generated from ChapterA1c.lean — theorem BookProof.ChapterA.cType_exhaustive
import Mathlib
import Definitions.Def_ChapterA1c
import Definitions.Def_ChapterA
open BookProof.ChapterA
open BookProof.ChapterA


open scoped ComplexConjugate InnerProductSpace RealInnerProductSpace

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]

theorem BookProof.ChapterA.cType_exhaustive (M : System ℂ V) :
    IsCReal M ∨ IsCPseudoreal M ∨ IsCComplex M := by sorry
