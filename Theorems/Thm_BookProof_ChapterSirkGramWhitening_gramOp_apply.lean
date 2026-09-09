-- Generated from ChapterSirkGramWhitening.lean — theorem BookProof.ChapterSirkGramWhitening.gramOp_apply
import Mathlib
import Definitions.Def_ChapterSirkGramWhitening
open BookProof.ChapterSirkGramWhitening








noncomputable section


open scoped InnerProductSpace
open Matrix
open BookProof.ChapterH4 BookProof.ChapterSirkWhitening

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]

theorem BookProof.ChapterSirkGramWhitening.gramOp_apply {m : ℕ} (w : Fin m → E) (c : EuclideanSpace ℂ (Fin m)) (i : Fin m) :
    gramOp w c i = ∑ j, ⟪w i, w j⟫_ℂ * c j := by sorry
