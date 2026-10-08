-- Generated from ChapterA1f.lean — theorem BookProof.ChapterA.conjFixed_ne_bot
import Mathlib
import Definitions.Def_ChapterA1f
import Definitions.Def_ChapterA1
import Definitions.Def_ChapterA
open BookProof.ChapterA
open BookProof.ChapterA


open scoped ComplexConjugate InnerProductSpace RealInnerProductSpace


attribute [local instance] InnerProductSpace.rclikeToReal

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]


theorem BookProof.ChapterA.conjFixed_ne_bot [Nontrivial V] (θ : AntiUnitary V) (hθ : ∀ x, θ (θ x) = x) :
    conjFixed θ ≠ ⊥ := by sorry
