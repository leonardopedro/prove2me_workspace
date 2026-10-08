-- Generated from ChapterCollapseDiagonal.lean — theorem BookProof.ChapterCollapseDiagonal.trace_diagonal_mul_diag
import Mathlib
import Definitions.Def_ChapterCollapseDiagonal
open BookProof.ChapterCollapseDiagonal


open scoped BigOperators
open Matrix


variable {n : ℕ}


theorem BookProof.ChapterCollapseDiagonal.trace_diagonal_mul_diag (ρ D : Matrix (Fin n) (Fin n) ℂ) (hρ : IsDiagonal ρ) :
    (ρ * D).trace = ∑ i, ρ i i * D i i := by sorry
