-- Generated from ChapterA1e.lean — theorem BookProof.ChapterA.inf_JY_Jinvariant
import Mathlib
import Definitions.Def_ChapterA1e
import Definitions.Def_ChapterA
open BookProof.ChapterA


open scoped ComplexConjugate InnerProductSpace RealInnerProductSpace


attribute [local instance] InnerProductSpace.rclikeToReal

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]


theorem BookProof.ChapterA.inf_JY_Jinvariant (Y : Submodule ℝ V) :
    ∀ x ∈ Y ⊓ JY Y, Jmap x ∈ Y ⊓ JY Y := by sorry
