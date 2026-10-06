-- Generated from ChapterNavierStokesMomentumEsa.lean — solution of BookProof.NavierStokesFlow.MomentumEsa.fockSymbol_add
import Mathlib
import Definitions.Def_ChapterNavierStokesMomentumEsa
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.MomentumEsa





open LpNat BookProof.FarisLavine IkebeKato FarisLavineLift DiagonalEsa

variable {ι : Type*}

set_option maxHeartbeats 1000000 in
theorem solution (n : ℕ → ℝ) (a b : Config) :
    fockSymbol n (a + b) + 1 = fockSymbol n a + fockSymbol n b := by

  have hsum : (Finsupp.sum (a + b) fun k m => (m : ℝ) * n k)
      = (Finsupp.sum a fun k m => (m : ℝ) * n k) + Finsupp.sum b fun k m => (m : ℝ) * n k :=
    Finsupp.sum_add_index' (fun k => by simp) (fun k m₁ m₂ => by push_cast; ring)
  simp only [fockSymbol]
  rw [hsum]
  ring
