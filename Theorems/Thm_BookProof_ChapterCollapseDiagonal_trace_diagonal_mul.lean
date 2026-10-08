-- Generated from ChapterCollapseDiagonal.lean — theorem BookProof.ChapterCollapseDiagonal.trace_diagonal_mul
import Mathlib
import Definitions.Def_ChapterCollapseDiagonal
open BookProof.ChapterCollapseDiagonal


open scoped BigOperators
open Matrix


variable {n : ℕ}


theorem BookProof.ChapterCollapseDiagonal.trace_diagonal_mul (ρ O : Matrix (Fin n) (Fin n) ℂ) (hρ : IsDiagonal ρ) :
    (ρ * O).trace = ∑ i, ρ i i * O i i := by sorry
