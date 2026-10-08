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
theorem solution (N : D →ₗ[ℂ] D) (v : D)
    (hpos : 0 ≤ (inner ℂ ((N v : D) : F) ((v : F)) : ℂ).re) :
    ‖((N v : D) : F)‖ ≤ ‖((((N + LinearMap.id : D →ₗ[ℂ] D)) v : D) : F)‖ :=
  ty to the comparison operator can only help, provided the
  comparison operator is non-negative on the state. -/
  theorem norm_le_norm_add_id (N : D →ₗ[ℂ] D) (v : D)
