-- Generated from ChapterNavierStokesFarisLavineLift.lean — theorem BookProof.NavierStokesFlow.FarisLavineLift.norm_le_norm_add_id
import Mathlib
import Definitions.Def_ChapterNavierStokesFarisLavineLift
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.FarisLavineLift

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {d : ℕ} (c : ComparisonData F d)
variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] {D : Submodule ℂ F}
variable {κ : Type*}




open FullEsa

   refine Finset.sum_le_sum fun k hk => ?_
    rw [Finset.mul_sum]
    exact Finset.sum_le_sum fun l hl => le_trans (le_abs_self _) (hpair k hk l hl)
  nlinarith [norm_nonneg (((∑ k ∈ s, h k) v : D) : F),
    norm_nonneg (((∑ k ∈ s, n k) v : D) : F),
    mul_nonneg hc (norm_nonneg (((∑ k ∈ s, n k) v : D) : F))]

/-- Adding the identi := by sorry
