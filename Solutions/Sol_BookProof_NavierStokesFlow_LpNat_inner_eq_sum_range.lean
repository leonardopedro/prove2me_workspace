-- Generated from ChapterNavierStokesDeficiency.lean — solution of BookProof.NavierStokesFlow.LpNat.inner_eq_sum_range
import Mathlib
import Definitions.Def_ChapterNavierStokesDeficiency
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.LpNat










open scoped ENNReal

set_option maxHeartbeats 1000000 in
theorem solution {f g : L2N} {N : ℕ} (hf : ∀ n, N ≤ n → (f : ℕ → ℂ) n = 0) :
    (inner ℂ f g : ℂ)
      = ∑ n ∈ Finset.range N, starRingEnd ℂ ((f : ℕ → ℂ) n) * (g : ℕ → ℂ) n := by

  have h0 : ∀ n ∉ Finset.range N, ((g : ℕ → ℂ) n) * starRingEnd ℂ ((f : ℕ → ℂ) n) = 0 := by
    intro n hn
    rw [hf n (by simpa using hn)]
    simp
  rw [lp.inner_eq_tsum]
  simp only [RCLike.inner_apply]
  rw [tsum_eq_sum h0]
  exact Finset.sum_congr rfl fun n _ => mul_comm _ _
