-- Generated from ChapterReconstruct.lean — solution of BookProof.ChapterReconstruct.offDiag_of_isDeterministicCol
import Mathlib
import Definitions.Def_ChapterReconstruct
open BookProof.ChapterReconstruct



open scoped BigOperators
open Finset


variable {n : ℕ}

variable {n : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (U : Fin n → Fin n → ℂ) (a : Fin n)
    (hU : IsDeterministicCol U a) (Ψ : Fin n → ℂ) : offDiag U a Ψ = 0 := by

  refine Finset.sum_eq_zero fun k hk => Finset.sum_eq_zero fun b hb => ?_
  -- Current `grind` cannot instantiate the `IsDeterministicCol` hypothesis here, so we
  -- split on `k = b` and extract the zero column factor by hand.
  by_cases hkb : k = b
  · simp [hkb]
  · rw [if_neg hkb]
    calc (starRingEnd ℂ) (U k a) * Ψ k * (starRingEnd ℂ) (Ψ b) * U b a
        = ((starRingEnd ℂ) (U k a) * U b a) * (Ψ k * (starRingEnd ℂ) (Ψ b)) := by ring
      _ = 0 * (Ψ k * (starRingEnd ℂ) (Ψ b)) := by rw [hU b k (fun h => hkb h.symm)]
      _ = 0 := by ring
