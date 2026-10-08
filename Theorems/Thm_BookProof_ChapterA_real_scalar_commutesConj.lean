-- Generated from ChapterA2b.lean — theorem BookProof.ChapterA.real_scalar_commutesConj
import Mathlib
import Definitions.Def_ChapterA2b
import Definitions.Def_ChapterA1
import Definitions.Def_ChapterA
open BookProof.ChapterA
open BookProof.ChapterA


open scoped ComplexConjugate InnerProductSpace


variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]


theorem BookProof.ChapterA.real_scalar_commutesConj (θ : AntiUnitary V) (r : ℝ) :
    CommutesConj θ (((r : ℂ)) • (1 : V →L[ℂ] V)) := by sorry
