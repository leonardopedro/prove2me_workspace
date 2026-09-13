-- Generated from ChapterNavierStokesFarisLavineLift.lean — solution of BookProof.NavierStokesFlow.FarisLavineLift.ComparisonData.comparison_ge_norm_sq
import Mathlib
import Definitions.Def_ChapterNavierStokesFarisLavineLift
import Theorems.Thm_BookProof_NavierStokesFlow_FarisLavineLift_ComparisonData_comparison_inner_eq
open BookProof.NavierStokesFlow.FarisLavineLift.ComparisonData
open BookProof.NavierStokesFlow











open FullEsa



variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]






variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]



variable {d : ℕ} (c : ComparisonData F d)

set_option maxHeartbeats 1000000 in
theorem solution (v : c.D) :
    ‖(v : F)‖ ^ 2 ≤ (inner ℂ ((v : F)) ((c.comparison v : c.D) : F) : ℂ).re := by

  rw [c.comparison_inner_eq v]
  have h1 : (0 : ℝ) ≤ ∑ i, ‖((c.mom i v : c.D) : F)‖ ^ 2 :=
    Finset.sum_nonneg fun i _ => sq_nonneg _
  have h2 : (0 : ℝ) ≤ ∑ i, ‖((c.drift i v : c.D) : F)‖ ^ 2 :=
    Finset.sum_nonneg fun i _ => sq_nonneg _
  linarith
