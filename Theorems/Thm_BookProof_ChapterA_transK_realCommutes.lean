-- Generated from ChapterA2e.lean — theorem BookProof.ChapterA.transK_realCommutes
import Mathlib
import Definitions.Def_ChapterA2e
import Definitions.Def_ChapterA
open BookProof.ChapterA
open BookProof.ChapterA


open scoped ComplexConjugate InnerProductSpace


variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]
variable {W : Type*} [NormedAddCommGroup W] [InnerProductSpace ℂ W] [CompleteSpace W]


theorem BookProof.ChapterA.transK_realCommutes {M : System ℂ V} {N : System ℂ W}
    {β : V ≃ₗᵢ[ℝ] W} (hβ : IsRealSystemIso M N β) : RealCommutes N (transK β) := by sorry
