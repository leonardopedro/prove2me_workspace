-- Generated from ChapterCollapseDiagonal.lean — solution of BookProof.ChapterCollapseDiagonal.trace_diagonal_mul_diag
import Mathlib
import Definitions.Def_ChapterCollapseDiagonal
import Theorems.Thm_BookProof_ChapterCollapseDiagonal_trace_diagonal_mul
open BookProof.ChapterCollapseDiagonal



open scoped BigOperators
open Matrix


variable {n : ℕ}

variable {n : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (ρ D : Matrix (Fin n) (Fin n) ℂ) (hρ : IsDiagonal ρ) :
    (ρ * D).trace = ∑ i, ρ i i * D i i := trace_diagonal_mul ρ D hρ
