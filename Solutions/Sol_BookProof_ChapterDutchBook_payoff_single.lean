-- Generated from ChapterDutchBook.lean — solution of BookProof.ChapterDutchBook.payoff_single
import Mathlib
import Definitions.Def_ChapterDutchBook
open BookProof.ChapterDutchBook



open scoped BigOperators
open Finset


variable {Ω : Type*} [DecidableEq Ω]

variable {Ω : Type*} [DecidableEq Ω]

set_option maxHeartbeats 1000000 in
theorem solution (Pr : Finset Ω → ℝ) (A₀ : Finset Ω) (s₀ : ℝ) (ω : Ω) :
    payoff Pr ![A₀] ![s₀] ω = s₀ * (betIndicator A₀ ω - Pr A₀) := by

  simp [payoff]
