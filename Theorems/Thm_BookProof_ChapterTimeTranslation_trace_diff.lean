-- Generated from ChapterTimeTranslation.lean — theorem BookProof.ChapterTimeTranslation.trace_diff
import Mathlib
import Definitions.Def_ChapterTimeTranslation
import Definitions.Def_ChapterReconstruct
open BookProof.ChapterReconstruct
open BookProof.ChapterTimeTranslation


open scoped BigOperators
open Finset Matrix
open BookProof.ChapterReconstruct


variable {n : ℕ}


theorem BookProof.ChapterTimeTranslation.trace_diff (U : Matrix (Fin n) (Fin n) ℂ) (a : Fin n) (Ψ : Fin n → ℂ) :
    (rho Ψ * measOp U a).trace - (diagPart (rho Ψ) * measOp U a).trace
      = offDiag U a Ψ := by sorry
