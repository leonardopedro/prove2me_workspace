-- Generated from ChapterNavierStokesDeficiency.lean — theorem BookProof.NavierStokesFlow.LpNat.inner_eq_sum_range
import Mathlib
import Definitions.Def_ChapterNavierStokesDeficiency
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.LpNat









open scoped ENNReal

theorem BookProof.NavierStokesFlow.LpNat.inner_eq_sum_range {f g : L2N} {N : ℕ} (hf : ∀ n, N ≤ n → (f : ℕ → ℂ) n = 0) :
    (inner ℂ f g : ℂ)
      = ∑ n ∈ Finset.range N, starRingEnd ℂ ((f : ℕ → ℂ) n) * (g : ℕ → ℂ) n := by sorry
