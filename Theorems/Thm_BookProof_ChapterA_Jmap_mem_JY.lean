-- Generated from ChapterA1e.lean — theorem BookProof.ChapterA.Jmap_mem_JY
import Mathlib
import Definitions.Def_ChapterA1e
import Definitions.Def_ChapterA
open BookProof.ChapterA

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]


open scoped ComplexConjugate InnerProductSpace RealInnerProductSpace


attribute [local instance] InnerProductSpace.rclikeToReal


theorem BookProof.ChapterA.Jmap_mem_JY {Y : Submodule ℝ V} {y : V} (hy : y ∈ Y) : Jmap y ∈ JY Y := by sorry
