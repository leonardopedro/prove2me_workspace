-- Generated from ChapterReconstruct.lean — solution of BookProof.ChapterReconstruct.offDiag_eq
import Mathlib
import Definitions.Def_ChapterReconstruct
open BookProof.ChapterReconstruct



open scoped BigOperators
open Finset


variable {n : ℕ}

variable {n : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (U : Fin n → Fin n → ℂ) (a : Fin n) (Ψ : Fin n → ℂ) :
    offDiag U a Ψ =
      (∑ k : Fin n, (starRingEnd ℂ) (U k a) * Ψ k) *
        (∑ b : Fin n, (starRingEnd ℂ) (Ψ b) * U b a) -
      ∑ k : Fin n,
        (starRingEnd ℂ) (U k a) * Ψ k * (starRingEnd ℂ) (Ψ k) * U k a := by

  simp only [offDiag, sum_mul _ _ _];
  simp [ Finset.sum_ite, Finset.filter_ne, Finset.mul_sum _ _ _, mul_assoc ]
