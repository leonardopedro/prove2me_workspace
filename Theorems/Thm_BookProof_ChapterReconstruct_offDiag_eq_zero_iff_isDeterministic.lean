-- Generated from ChapterReconstruct.lean — theorem BookProof.ChapterReconstruct.offDiag_eq_zero_iff_isDeterministic
import Mathlib
import Definitions.Def_ChapterReconstruct
open BookProof.ChapterReconstruct

variable {n : ℕ}


open scoped BigOperators
open Finset



theorem BookProof.ChapterReconstruct.offDiag_eq_zero_iff_isDeterministic (U : Fin n → Fin n → ℂ) :
    (∀ (a : Fin n) (Ψ : Fin n → ℂ), offDiag U a Ψ = 0) ↔ IsDeterministic U := by sorry
