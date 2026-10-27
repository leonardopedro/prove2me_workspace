-- Generated from ChapterTimeTranslation.lean — solution of BookProof.ChapterTimeTranslation.trace_diff
import Mathlib
import Definitions.Def_ChapterTimeTranslation
import Theorems.Thm_BookProof_ChapterTimeTranslation_trace_rho_measOp
import Theorems.Thm_BookProof_ChapterTimeTranslation_trace_diagPart_measOp
import Theorems.Thm_BookProof_ChapterReconstruct_offDiag_eq
open BookProof.ChapterTimeTranslation



open scoped BigOperators
open Finset Matrix
open BookProof.ChapterReconstruct


variable {n : ℕ}

variable {n : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (U : Matrix (Fin n) (Fin n) ℂ) (a : Fin n) (Ψ : Fin n → ℂ) :
    (rho Ψ * measOp U a).trace - (diagPart (rho Ψ) * measOp U a).trace
      = offDiag U a Ψ := by

  rw [trace_rho_measOp, trace_diagPart_measOp, offDiag_eq (U := fun i j => U i j)]
