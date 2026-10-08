-- Generated from ChapterA1c.lean — theorem BookProof.ChapterA.IsConjugation.commutesAntiUnitary
import Mathlib
import Definitions.Def_ChapterA1c
import Definitions.Def_ChapterA
import Definitions.Def_ChapterA1
open BookProof.ChapterA
open BookProof.ChapterA
open BookProof.ChapterA


open scoped ComplexConjugate InnerProductSpace RealInnerProductSpace

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]

theorem BookProof.ChapterA.IsConjugation.commutesAntiUnitary {M : System ℂ V} {θ : AntiUnitary V}
    (h : IsConjugation M θ) : CommutesAntiUnitary M θ := by sorry
