-- Generated from ChapterReconstruct.lean — theorem BookProof.ChapterReconstruct.offDiag_eq
import Mathlib
import Definitions.Def_ChapterReconstruct
open BookProof.ChapterReconstruct

variable {n : ℕ}


open scoped BigOperators
open Finset



theorem BookProof.ChapterReconstruct.offDiag_eq (U : Fin n → Fin n → ℂ) (a : Fin n) (Ψ : Fin n → ℂ) :
    offDiag U a Ψ =
      (∑ k : Fin n, (starRingEnd ℂ) (U k a) * Ψ k) *
        (∑ b : Fin n, (starRingEnd ℂ) (Ψ b) * U b a) -
      ∑ k : Fin n,
        (starRingEnd ℂ) (U k a) * Ψ k * (starRingEnd ℂ) (Ψ k) * U k a := by sorry
