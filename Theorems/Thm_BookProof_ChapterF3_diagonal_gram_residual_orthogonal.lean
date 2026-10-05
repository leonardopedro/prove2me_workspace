-- Generated from ChapterF3.lean — theorem BookProof.ChapterF3.diagonal_gram_residual_orthogonal
import Mathlib
import Definitions.Def_ChapterF3
open BookProof.ChapterF3

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]


open scoped BigOperators
open Polynomial


noncomputable section

theorem BookProof.ChapterF3.diagonal_gram_residual_orthogonal {ι : Type*} [Fintype ι]
    (g : ι → E) (b : E)
    (horth : ∀ i j, i ≠ j → inner (𝕜 := by sorry
