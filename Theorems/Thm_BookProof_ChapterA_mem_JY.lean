-- Generated from ChapterA1e.lean — theorem BookProof.ChapterA.mem_JY
import Mathlib
import Definitions.Def_ChapterA1e
import Definitions.Def_ChapterA
open BookProof.ChapterA

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]


open scoped ComplexConjugate InnerProductSpace RealInnerProductSpace


attribute [local instance] InnerProductSpace.rclikeToReal


theorem BookProof.ChapterA.mem_JY {Y : Submodule ℝ V} {x : V} : x ∈ JY Y ↔ ∃ y ∈ Y, Jmap y = x := by sorry
