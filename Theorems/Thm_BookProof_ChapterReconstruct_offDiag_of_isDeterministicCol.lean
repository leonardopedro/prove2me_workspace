-- Generated from ChapterReconstruct.lean — theorem BookProof.ChapterReconstruct.offDiag_of_isDeterministicCol
import Mathlib
import Definitions.Def_ChapterReconstruct
open BookProof.ChapterReconstruct


open scoped BigOperators
open Finset


variable {n : ℕ}


theorem BookProof.ChapterReconstruct.offDiag_of_isDeterministicCol (U : Fin n → Fin n → ℂ) (a : Fin n)
    (hU : IsDeterministicCol U a) (Ψ : Fin n → ℂ) : offDiag U a Ψ = 0 := by sorry
