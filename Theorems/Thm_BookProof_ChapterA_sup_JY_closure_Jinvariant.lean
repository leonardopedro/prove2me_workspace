-- Generated from ChapterA1e.lean — theorem BookProof.ChapterA.sup_JY_closure_Jinvariant
import Mathlib
import Definitions.Def_ChapterA1e
import Definitions.Def_ChapterA
open BookProof.ChapterA

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]


open scoped ComplexConjugate InnerProductSpace RealInnerProductSpace


attribute [local instance] InnerProductSpace.rclikeToReal


theorem BookProof.ChapterA.sup_JY_closure_Jinvariant (Y : Submodule ℝ V) :
    ∀ x ∈ (Y ⊔ JY Y).topologicalClosure, Jmap x ∈ (Y ⊔ JY Y).topologicalClosure := by sorry
