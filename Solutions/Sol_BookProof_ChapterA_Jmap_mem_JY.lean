-- Generated from ChapterA1e.lean — solution of BookProof.ChapterA.Jmap_mem_JY
import Mathlib
import Definitions.Def_ChapterA1e
import Theorems.Thm_BookProof_ChapterA_mem_JY
open BookProof.ChapterA



open scoped ComplexConjugate InnerProductSpace RealInnerProductSpace


attribute [local instance] InnerProductSpace.rclikeToReal

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]

set_option maxHeartbeats 1000000 in
theorem solution {Y : Submodule ℝ V} {y : V} (hy : y ∈ Y) : Jmap y ∈ JY Y := mem_JY.2 ⟨y, hy, rfl⟩
