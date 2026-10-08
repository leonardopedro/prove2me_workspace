-- Generated from ChapterTimeTranslation.lean — theorem BookProof.ChapterTimeTranslation.trace_rho_measOp
import Definitions.Def_ChapterReconstruct
import Mathlib
import Definitions.Def_ChapterTimeTranslation
open BookProof.ChapterTimeTranslation


open scoped BigOperators
open Finset Matrix
open BookProof.ChapterReconstruct


variable {n : ℕ}


theorem BookProof.ChapterTimeTranslation.trace_rho_measOp (U : Matrix (Fin n) (Fin n) ℂ) (a : Fin n) (Ψ : Fin n → ℂ) :
    (rho Ψ * measOp U a).trace =
      (∑ k : Fin n, (starRingEnd ℂ) (U k a) * Ψ k) *
        (∑ b : Fin n, (starRingEnd ℂ) (Ψ b) * U b a) := by sorry
