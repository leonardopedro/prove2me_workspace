-- Generated from ChapterNavierStokesMomentumEsa.lean — solution of BookProof.NavierStokesFlow.MomentumEsa.fockSymbol_ge_one
import Mathlib
import Definitions.Def_ChapterNavierStokesMomentumEsa
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.MomentumEsa





open LpNat BookProof.FarisLavine IkebeKato FarisLavineLift DiagonalEsa

variable {ι : Type*}

set_option maxHeartbeats 1000000 in
theorem solution (n : ℕ → ℝ) (hn : ∀ k, 0 ≤ n k) (a : Config) :
    1 ≤ fockSymbol n a := by

  have h : (0 : ℝ) ≤ a.sum fun k m => (m : ℝ) * n k :=
    Finset.sum_nonneg fun k _ => mul_nonneg (Nat.cast_nonneg _) (hn k)
  simp only [fockSymbol]
  linarith
