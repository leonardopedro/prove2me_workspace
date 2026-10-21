-- Generated from ChapterA1f.lean — solution of BookProof.ChapterA.conjFixed_isClosed
import Mathlib
import Definitions.Def_ChapterA1f
open BookProof.ChapterA



open scoped ComplexConjugate InnerProductSpace RealInnerProductSpace


attribute [local instance] InnerProductSpace.rclikeToReal

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]

set_option maxHeartbeats 1000000 in
theorem solution (θ : AntiUnitary V) :
    IsClosed ((conjFixed θ : Submodule ℝ V) : Set V) := by

  have h : ((conjFixed θ : Submodule ℝ V) : Set V) = {v | θ v = v} := rfl
  rw [h]; exact isClosed_eq θ.continuous continuous_id
