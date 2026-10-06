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

  refine Finset.sum_eq_zero fun k hk => Finset.sum_eq_zero fun b hb => ?_;
  grind +locals
