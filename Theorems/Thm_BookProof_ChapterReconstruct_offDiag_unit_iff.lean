-- Generated from ChapterReconstruct.lean — theorem BookProof.ChapterReconstruct.offDiag_unit_iff
import Mathlib
import Definitions.Def_ChapterReconstruct
open BookProof.ChapterReconstruct


open scoped BigOperators
open Finset


variable {n : ℕ}


theorem BookProof.ChapterReconstruct.offDiag_unit_iff (U : Fin n → Fin n → ℂ) :
    (∀ (a : Fin n) (Ψ : Fin n → ℂ), (∑ k : Fin n, ‖Ψ k‖ ^ 2) = 1 →
        offDiag U a Ψ = 0) ↔ IsDeterministic U := by sorry
