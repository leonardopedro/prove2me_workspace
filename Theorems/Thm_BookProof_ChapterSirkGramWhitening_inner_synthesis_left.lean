-- Generated from ChapterSirkGramWhitening.lean — theorem BookProof.ChapterSirkGramWhitening.inner_synthesis_left
import Mathlib
import Definitions.Def_ChapterSirkGramWhitening
open BookProof.ChapterSirkGramWhitening








noncomputable section


open scoped InnerProductSpace
open Matrix
open BookProof.ChapterH4 BookProof.ChapterSirkWhitening

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]

theorem BookProof.ChapterSirkGramWhitening.inner_synthesis_left {m : ℕ} (w : Fin m → E) (c : EuclideanSpace ℂ (Fin m)) (x : E) :
    ⟪synthesis w c, x⟫_ℂ = ∑ i, (starRingEnd ℂ) (c i) * ⟪w i, x⟫_ℂ := by sorry
