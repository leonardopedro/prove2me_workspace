-- Generated from ChapterA1e.lean — solution of BookProof.ChapterA.proper_realification_subsystem_splits
import Mathlib
import Definitions.Def_ChapterA1e
import Theorems.Thm_BookProof_ChapterA_realification_splits
open BookProof.ChapterA



open scoped ComplexConjugate InnerProductSpace RealInnerProductSpace


attribute [local instance] InnerProductSpace.rclikeToReal

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]

set_option maxHeartbeats 1000000 in
theorem solution (M : System ℂ V) (h : M.IsIrreducible)
    {Y : Submodule ℝ V} (hY : (rxSystem M).IsSubsystem Y) (hbot : Y ≠ ⊥) (htop : Y ≠ ⊤) :
    Y ⊓ JY Y = ⊥ ∧ (Y ⊔ JY Y).topologicalClosure = ⊤ := by

  rcases realification_splits M h Y hY with h₁ | h₁ | h₁
  · exact absurd h₁ hbot
  · exact absurd h₁ htop
  · exact h₁
