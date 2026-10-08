-- Generated from ChapterA1e.lean — theorem BookProof.ChapterA.Jmap_mem_of_mem_JY
import Mathlib
import Definitions.Def_ChapterA1e
import Definitions.Def_ChapterA
open BookProof.ChapterA


open scoped ComplexConjugate InnerProductSpace RealInnerProductSpace


attribute [local instance] InnerProductSpace.rclikeToReal

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]


theorem BookProof.ChapterA.Jmap_mem_of_mem_JY {Y : Submodule ℝ V} {x : V} (hx : x ∈ JY Y) : Jmap x ∈ Y := by sorry
