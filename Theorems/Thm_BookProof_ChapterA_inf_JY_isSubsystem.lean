-- Generated from ChapterA1e.lean — theorem BookProof.ChapterA.inf_JY_isSubsystem
import Mathlib
import Definitions.Def_ChapterA1e
import Definitions.Def_ChapterA
open BookProof.ChapterA
open BookProof.ChapterA

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]


open scoped ComplexConjugate InnerProductSpace RealInnerProductSpace


attribute [local instance] InnerProductSpace.rclikeToReal


theorem BookProof.ChapterA.inf_JY_isSubsystem (M : System ℂ V) {Y : Submodule ℝ V}
    (hY : (rxSystem M).IsSubsystem Y) : (rxSystem M).IsSubsystem (Y ⊓ JY Y) := by sorry
