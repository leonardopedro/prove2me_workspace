-- Generated from ChapterNavierStokesMomentumEsa.lean — solution of BookProof.NavierStokesFlow.MomentumEsa.nsSymbol_ge_one
import Mathlib
import Definitions.Def_ChapterNavierStokesMomentumEsa
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.MomentumEsa





open LpNat BookProof.FarisLavine IkebeKato FarisLavineLift DiagonalEsa

variable {ι : Type*}

set_option maxHeartbeats 1000000 in
theorem solution (d : ℕ) (p q : Fin d → ℕ → ℝ) (k : ℕ) : 1 ≤ nsSymbol d p q k := by

  have h1 : (0 : ℝ) ≤ ∑ i, p i k ^ 2 := Finset.sum_nonneg fun i _ => sq_nonneg _
  have h2 : (0 : ℝ) ≤ ∑ i, q i k ^ 2 := Finset.sum_nonneg fun i _ => sq_nonneg _
  simp only [nsSymbol]
  linarith
