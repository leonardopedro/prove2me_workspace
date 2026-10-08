-- Generated from ChapterA2c.lean — theorem BookProof.ChapterA.qembed_injective
import Mathlib
import Definitions.Def_ChapterA2c
import Definitions.Def_ChapterA1
import Definitions.Def_ChapterA
open BookProof.ChapterA
open BookProof.ChapterA


open scoped ComplexConjugate InnerProductSpace Quaternion


variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]


theorem BookProof.ChapterA.qembed_injective [Nontrivial V] (θ : AntiUnitary V) (hθ : ∀ x, θ (θ x) = -x) :
    Function.Injective (qembed θ hθ) := by sorry
