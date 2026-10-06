-- Generated from ChapterDutchBook.lean — theorem BookProof.ChapterDutchBook.payoff_single
import Mathlib
import Definitions.Def_ChapterDutchBook
open BookProof.ChapterDutchBook

variable {Ω : Type*} [DecidableEq Ω]


open scoped BigOperators
open Finset



theorem BookProof.ChapterDutchBook.payoff_single (Pr : Finset Ω → ℝ) (A₀ : Finset Ω) (s₀ : ℝ) (ω : Ω) :
    payoff Pr ![A₀] ![s₀] ω = s₀ * (betIndicator A₀ ω - Pr A₀) := by sorry
