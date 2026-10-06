-- Generated from ChapterEll2Separable.lean — solution of BookProof.ChapterEll2Separable.eq_sum_single_of_mem_finSupport
import Mathlib
import Definitions.Def_ChapterEll2Separable
open BookProof.ChapterEll2Separable



open Filter Finset
open scoped ENNReal


open BookProof.ChapterRieszFischer

set_option maxHeartbeats 1000000 in
theorem solution (f : Ell2) {s : Finset ℕ}
    (hs : Function.support ((f : ℕ → ℝ)) ⊆ (s : Set ℕ)) :
    f = ∑ i ∈ s, lp.single 2 i ((f : ℕ → ℝ) i) := by

  have h₁ : HasSum (fun i => lp.single 2 i ((f : ℕ → ℝ) i)) f := riesz_fischer_hasSum f
  have h₂ : HasSum (fun i => lp.single 2 i ((f : ℕ → ℝ) i))
      (∑ i ∈ s, lp.single 2 i ((f : ℕ → ℝ) i)) := by
    refine hasSum_sum_of_ne_finset_zero ?_
    intro i hi
    have : (f : ℕ → ℝ) i = 0 := by
      by_contra h
      exact hi (by exact_mod_cast hs h)
    simp [this]
  exact h₁.unique h₂
