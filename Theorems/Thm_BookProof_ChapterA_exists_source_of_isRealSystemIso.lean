-- Generated from ChapterA2e.lean — theorem BookProof.ChapterA.exists_source_of_isRealSystemIso
import Mathlib
import Definitions.Def_ChapterA2e
import Definitions.Def_ChapterA
open BookProof.ChapterA
open BookProof.ChapterA

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]
variable {W : Type*} [NormedAddCommGroup W] [InnerProductSpace ℂ W] [CompleteSpace W]


open scoped ComplexConjugate InnerProductSpace



theorem BookProof.ChapterA.exists_source_of_isRealSystemIso {M : System ℂ V} {N : System ℂ W}
    {β : V ≃ₗᵢ[ℝ] W} (hβ : IsRealSystemIso M N β) {n : W →L[ℂ] W} (hn : n ∈ N.ops) :
    ∃ m ∈ M.ops, ∀ w, n w = β (m (β.symm w)) := by sorry
