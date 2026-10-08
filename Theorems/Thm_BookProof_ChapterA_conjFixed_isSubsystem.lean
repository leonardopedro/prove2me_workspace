-- Generated from ChapterA1f.lean — theorem BookProof.ChapterA.conjFixed_isSubsystem
import Mathlib
import Definitions.Def_ChapterA1f
import Definitions.Def_ChapterA
import Definitions.Def_ChapterA1
open BookProof.ChapterA
open BookProof.ChapterA
open BookProof.ChapterA


open scoped ComplexConjugate InnerProductSpace RealInnerProductSpace


attribute [local instance] InnerProductSpace.rclikeToReal

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]


theorem BookProof.ChapterA.conjFixed_isSubsystem (M : System ℂ V) (θ : AntiUnitary V) (hθ : IsConjugation M θ) :
    (rxSystem M).IsSubsystem (conjFixed θ) := by sorry
