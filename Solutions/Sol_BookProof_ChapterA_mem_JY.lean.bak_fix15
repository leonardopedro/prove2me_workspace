-- Generated from ChapterA1e.lean — solution of BookProof.ChapterA.mem_JY
import Mathlib
import Definitions.Def_ChapterA1e
open BookProof.ChapterA



open scoped ComplexConjugate InnerProductSpace RealInnerProductSpace


attribute [local instance] InnerProductSpace.rclikeToReal

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]

set_option maxHeartbeats 1000000 in
theorem solution {Y : Submodule ℝ V} {x : V} : x ∈ JY Y ↔ ∃ y ∈ Y, Jmap y = x := by

  simp [JY, Submodule.mem_map]
