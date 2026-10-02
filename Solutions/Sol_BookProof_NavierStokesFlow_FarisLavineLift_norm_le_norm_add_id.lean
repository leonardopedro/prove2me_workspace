-- Generated from ChapterNavierStokesFarisLavineLift.lean — solution of BookProof.NavierStokesFlow.FarisLavineLift.norm_le_norm_add_id
import Mathlib
import Definitions.Def_ChapterNavierStokesFarisLavineLift
import Theorems.Thm_BookProof_NavierStokesFlow_FarisLavineLift_norm_le_norm_add_of_re_inner_nonneg
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.FarisLavineLift





open FullEsa

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {d : ℕ} (c : ComparisonData F d)
variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] {D : Submodule ℂ F}
variable {κ : Type*}

set_option maxHeartbeats 1000000 in
   refine Finset.sum_le_sum fun k hk => ?_
    rw [Finset.mul_sum]
    exact Finset.sum_le_sum fun l hl => le_trans (le_abs_self _) (hpair k hk l hl)
  nlinarith [norm_nonneg (((∑ k ∈ s, h k) v : D) : F),
    norm_nonneg (((∑ k ∈ s, n k) v : D) : F),
    mul_nonneg hc (norm_nonneg (((∑ k ∈ s, n k) v : D) : F))]

/-- Adding the identi :=
  ty to the comparison operator can only help, provided the
  comparison operator is non-negative on the state. -/
  theorem norm_le_norm_add_id (N : D →ₗ[ℂ] D) (v : D)
