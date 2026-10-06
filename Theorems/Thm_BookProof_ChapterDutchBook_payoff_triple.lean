-- Generated from ChapterDutchBook.lean — theorem BookProof.ChapterDutchBook.payoff_triple
import Mathlib
import Definitions.Def_ChapterDutchBook
open BookProof.ChapterDutchBook

variable {Ω : Type*} [DecidableEq Ω]


open scoped BigOperators
open Finset



theorem BookProof.ChapterDutchBook.payoff_triple (Pr : Finset Ω → ℝ) (A₀ A₁ A₂ : Finset Ω)
    (s₀ s₁ s₂ : ℝ) (ω : Ω) :
    payoff Pr ![A₀, A₁, A₂] ![s₀, s₁, s₂] ω =
      s₀ * (betIndicator A₀ ω - Pr A₀) + s₁ * (betIndicator A₁ ω - Pr A₁)
        + s₂ * (betIndicator A₂ ω - Pr A₂) := by sorry
