-- Generated from ChapterCollapseDiagonal.lean — theorem BookProof.ChapterCollapseDiagonal.trace_diag_nullDiag_zero
import Mathlib
import Definitions.Def_ChapterCollapseDiagonal
open BookProof.ChapterCollapseDiagonal

variable {n : ℕ}


open scoped BigOperators
open Matrix



theorem BookProof.ChapterCollapseDiagonal.trace_diag_nullDiag_zero (ρ O : Matrix (Fin n) (Fin n) ℂ)
    (hρ : IsDiagonal ρ) (hO : ∀ i, O i i = 0) :
    (ρ * O).trace = 0 := by sorry
