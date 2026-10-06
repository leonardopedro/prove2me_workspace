-- Generated from ChapterReconstruct.lean — theorem BookProof.ChapterReconstruct.isDeterministicCol_of_offDiag
import Mathlib
import Definitions.Def_ChapterReconstruct
open BookProof.ChapterReconstruct

variable {n : ℕ}


open scoped BigOperators
open Finset



theorem BookProof.ChapterReconstruct.isDeterministicCol_of_offDiag (U : Fin n → Fin n → ℂ) (a : Fin n)
    (hU : ∀ Ψ : Fin n → ℂ, offDiag U a Ψ = 0) : IsDeterministicCol U a := by sorry
