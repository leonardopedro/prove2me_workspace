-- Generated from ChapterA2e.lean — theorem BookProof.ChapterA.isRealSystemIso_trans_commuting
import Mathlib
import Definitions.Def_ChapterA2e
import Definitions.Def_ChapterA
open BookProof.ChapterA
open BookProof.ChapterA

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]
variable {W : Type*} [NormedAddCommGroup W] [InnerProductSpace ℂ W] [CompleteSpace W]
variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]


open scoped ComplexConjugate InnerProductSpace



theorem BookProof.ChapterA.isRealSystemIso_trans_commuting {M : System ℂ V} {N : System ℂ W}
    {β : V ≃ₗᵢ[ℝ] W} (hβ : IsRealSystemIso M N β) {U : W ≃ₗᵢ[ℝ] W}
    (hU : RealCommutes N (betaR U)) : IsRealSystemIso M N (β.trans U) := by sorry
