-- Generated from ChapterA2e.lean — theorem BookProof.ChapterA.rot_inj
import Mathlib
import Definitions.Def_ChapterA2e
import Definitions.Def_ChapterA1
import Definitions.Def_ChapterA
open BookProof.ChapterA
open BookProof.ChapterA


open scoped ComplexConjugate InnerProductSpace


variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]
variable {W : Type*} [NormedAddCommGroup W] [InnerProductSpace ℂ W] [CompleteSpace W]

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]

theorem BookProof.ChapterA.rot_inj (θ : AntiUnitary H) (hθ : ∀ x, θ (θ x) = -x) [Nontrivial H]
    {a b c d : ℂ} (h : rot θ a b = rot θ c d) : a = c ∧ b = d := by sorry
