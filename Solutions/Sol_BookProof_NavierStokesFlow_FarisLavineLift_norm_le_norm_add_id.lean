-- Generated from ChapterNavierStokesFarisLavineLift.lean — solution of BookProof.NavierStokesFlow.FarisLavineLift.norm_le_norm_add_id
import Mathlib
import Definitions.Def_ChapterNavierStokesFarisLavineLift
import Theorems.Thm_BookProof_NavierStokesFlow_FarisLavineLift_norm_le_norm_add_of_re_inner_nonneg
import Definitions.Def_ChapterNavierStokesFullEsa
import Definitions.Def_ChapterNavierStokesDeficiency
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.FarisLavineLift











open BookProof.NavierStokesFlow.FullEsa



variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]






variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]



variable {d : ℕ} (c : ComparisonData F d)











open BookProof.NavierStokesFlow.LpNat BookProof.NavierStokesFlow.DiagonalEsa









variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] {D : Submodule ℂ F}
variable {κ : Type*}

set_option maxHeartbeats 1000000 in
theorem solution (N : D →ₗ[ℂ] D) (v : D)
    (hpos : 0 ≤ (inner ℂ ((N v : D) : F) ((v : F)) : ℂ).re) :
    ‖((N v : D) : F)‖ ≤ ‖((((N + LinearMap.id : D →ₗ[ℂ] D)) v : D) : F)‖ := by

  have : ((((N + LinearMap.id : D →ₗ[ℂ] D)) v : D) : F) = ((N v : D) : F) + (v : F) := by
    simp
  rw [this]
  exact norm_le_norm_add_of_re_inner_nonneg hpos
