-- Generated from ChapterAbelianVonNeumannFinite.lean — theorem BookProof.ChapterAbelianVonNeumannFinite.commutes_diagonal_iff
import Mathlib
import Definitions.Def_ChapterAbelianVonNeumannFinite
open BookProof.ChapterAbelianVonNeumannFinite

variable {n : Type*} [Fintype n] [DecidableEq n]


open Matrix



theorem BookProof.ChapterAbelianVonNeumannFinite.commutes_diagonal_iff (e : n → ℂ) (he : Function.Injective e) (M : Matrix n n ℂ) :
    M * diagonal e = diagonal e * M ↔ ∃ d : n → ℂ, M = diagonal d := by sorry
