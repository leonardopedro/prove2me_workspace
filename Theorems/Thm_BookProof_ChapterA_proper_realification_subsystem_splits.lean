-- Generated from ChapterA1e.lean — theorem BookProof.ChapterA.proper_realification_subsystem_splits
import Mathlib
import Definitions.Def_ChapterA1e
import Definitions.Def_ChapterA
open BookProof.ChapterA
open BookProof.ChapterA

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]


open scoped ComplexConjugate InnerProductSpace RealInnerProductSpace


attribute [local instance] InnerProductSpace.rclikeToReal


theorem BookProof.ChapterA.proper_realification_subsystem_splits (M : System ℂ V) (h : M.IsIrreducible)
    {Y : Submodule ℝ V} (hY : (rxSystem M).IsSubsystem Y) (hbot : Y ≠ ⊥) (htop : Y ≠ ⊤) :
    Y ⊓ JY Y = ⊥ ∧ (Y ⊔ JY Y).topologicalClosure = ⊤ := by sorry
