-- Generated from ChapterH6.lean — theorem BookProof.ChapterH6.sirk_error_tendsto_zero
import Mathlib
import Definitions.Def_ChapterH6
open BookProof.ChapterH6

variable {E F : Type*}
  [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]
  [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]
variable {m : ℕ}


noncomputable section

open Filter Topology

theorem BookProof.ChapterH6.sirk_error_tendsto_zero (C Dmin h nv : ℝ) (hh : 0 < h) {ε : ℝ} (hε : 0 < ε) :
    ∀ᶠ m : ℕ in atTop, |sirkBound C Dmin h nv m| < ε := by sorry
