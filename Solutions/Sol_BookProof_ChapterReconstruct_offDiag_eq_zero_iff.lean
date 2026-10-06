-- Generated from ChapterReconstruct.lean — solution of BookProof.ChapterReconstruct.offDiag_eq_zero_iff
import Mathlib
import Definitions.Def_ChapterReconstruct
import Theorems.Thm_BookProof_ChapterReconstruct_offDiag_of_isDeterministicCol
import Theorems.Thm_BookProof_ChapterReconstruct_isDeterministicCol_of_offDiag
open BookProof.ChapterReconstruct



open scoped BigOperators
open Finset


variable {n : ℕ}

variable {n : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (U : Fin n → Fin n → ℂ) (a : Fin n) :
    (∀ Ψ : Fin n → ℂ, offDiag U a Ψ = 0) ↔ IsDeterministicCol U a := ⟨isDeterministicCol_of_offDiag U a, offDiag_of_isDeterministicCol U a⟩
