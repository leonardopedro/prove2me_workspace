-- Generated from ChapterA1d.lean — theorem BookProof.ChapterA.realSub_isSubsystem
import Mathlib
import Definitions.Def_ChapterA1d
import Definitions.Def_ChapterA
open BookProof.ChapterA
open BookProof.ChapterA

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V]


open scoped ComplexConjugate InnerProductSpace RealInnerProductSpace




attribute [local instance] InnerProductSpace.rclikeToReal


theorem BookProof.ChapterA.realSub_isSubsystem [CompleteSpace V] (M : System ℂ V) {X : Submodule ℂ V}
    (hX : (M).IsSubsystem X) : (rxSystem M).IsSubsystem (realSub X) := by sorry
