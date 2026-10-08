-- Generated from ChapterA1e.lean — theorem BookProof.ChapterA.realification_splits
import Mathlib
import Definitions.Def_ChapterA1e
import Definitions.Def_ChapterA
open BookProof.ChapterA
open BookProof.ChapterA


open scoped ComplexConjugate InnerProductSpace RealInnerProductSpace


attribute [local instance] InnerProductSpace.rclikeToReal

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]


theorem BookProof.ChapterA.realification_splits (M : System ℂ V) (h : M.IsIrreducible)
    (Y : Submodule ℝ V) (hY : (rxSystem M).IsSubsystem Y) :
    Y = ⊥ ∨ Y = ⊤ ∨ (Y ⊓ JY Y = ⊥ ∧ (Y ⊔ JY Y).topologicalClosure = ⊤) := by sorry
