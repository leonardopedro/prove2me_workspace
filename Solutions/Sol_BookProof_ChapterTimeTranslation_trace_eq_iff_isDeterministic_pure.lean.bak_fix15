-- Generated from ChapterTimeTranslation.lean — solution of BookProof.ChapterTimeTranslation.trace_eq_iff_isDeterministic_pure
import Mathlib
import Definitions.Def_ChapterTimeTranslation
import Theorems.Thm_BookProof_ChapterTimeTranslation_trace_diff
import Theorems.Thm_BookProof_ChapterReconstruct_offDiag_unit_iff
open BookProof.ChapterTimeTranslation



open scoped BigOperators
open Finset Matrix
open BookProof.ChapterReconstruct


variable {n : ℕ}

variable {n : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (U : Matrix (Fin n) (Fin n) ℂ) :
    (∀ (a : Fin n) (Ψ : Fin n → ℂ), (∑ k : Fin n, ‖Ψ k‖ ^ 2) = 1 →
        (diagPart (rho Ψ) * measOp U a).trace = (rho Ψ * measOp U a).trace)
      ↔ IsDeterministic U := by

  show (∀ (a : Fin n) (Ψ : Fin n → ℂ), (∑ k : Fin n, ‖Ψ k‖ ^ 2) = 1 →
        (diagPart (rho Ψ) * measOp U a).trace = (rho Ψ * measOp U a).trace)
      ↔ IsDeterministic (fun i j => U i j)
  rw [← offDiag_unit_iff]
  constructor
  · intro h a Ψ hΨ
    have hd := trace_diff U a Ψ
    rw [h a Ψ hΨ, sub_self] at hd
    exact hd.symm
  · intro h a Ψ hΨ
    have hd := trace_diff U a Ψ
    rw [h a Ψ hΨ, sub_eq_zero] at hd
    exact hd.symm
