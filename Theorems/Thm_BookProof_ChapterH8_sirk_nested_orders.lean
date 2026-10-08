-- Generated from ChapterH8.lean — theorem BookProof.ChapterH8.sirk_nested_orders
import Definitions.Def_ChapterH4
import Mathlib
import Definitions.Def_ChapterH8
import Definitions.Def_ChapterH5
import Definitions.Def_ChapterH6
open BookProof.ChapterH5
open BookProof.ChapterH6
open BookProof.ChapterH8


noncomputable section


open BookProof.ChapterH4 BookProof.ChapterH5 BookProof.ChapterH6

variable {K E : Type*} [Field K] [AddCommGroup E] [Module K E]
variable {E F G : Type*}
  [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]
  [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
  [NormedAddCommGroup G] [InnerProductSpace ℂ G] [CompleteSpace G]
variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]

theorem BookProof.ChapterH8.sirk_nested_orders {K E : Type*} [Field K] [AddCommGroup E] [Module K E]
    (H : E →ₗ[K] E) (v : E) (C Dmin h nv : ℝ)
    (hC : 0 ≤ C) (hD : 0 ≤ Dmin) (hnv : 0 ≤ nv) (hh : 0 ≤ h) :
    ∀ n : ℕ, krylovSpan H v n ≤ krylovSpan H v (n + 1)
      ∧ Set.Icc (0 : ℝ) (sirkBound C Dmin h nv (n + 1))
          ⊆ Set.Icc (0 : ℝ) (sirkBound C Dmin h nv n) := by sorry
