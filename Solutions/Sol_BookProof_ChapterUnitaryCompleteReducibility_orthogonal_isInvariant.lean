-- Generated from ChapterUnitaryCompleteReducibility.lean — solution of BookProof.ChapterUnitaryCompleteReducibility.orthogonal_isInvariant
import Mathlib
import Definitions.Def_ChapterUnitaryCompleteReducibility
import Theorems.Thm_BookProof_ChapterUnitaryCompleteReducibility_inv_mem_of_isInvariant
open BookProof.ChapterUnitaryCompleteReducibility




open Submodule

variable {G : Type*} [Group G] {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V]

variable {G : Type*} [Group G] {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V]

set_option maxHeartbeats 1000000 in
theorem solution {ρ : G →* (V ≃ₗᵢ[ℂ] V)} {W : Submodule ℂ V}
    (hW : IsInvariant ρ W) : IsInvariant ρ Wᗮ := by

  intro g y hy
  rw [Submodule.mem_orthogonal]
  intro x hx
  have hx' : (ρ g).symm x ∈ W := inv_mem_of_isInvariant hW g hx
  have := hy ((ρ g).symm x) hx'
  calc inner ℂ x (ρ g y) = inner ℂ (ρ g ((ρ g).symm x)) (ρ g y) := by
        rw [LinearIsometryEquiv.apply_symm_apply]
    _ = inner ℂ ((ρ g).symm x) y := LinearIsometryEquiv.inner_map_map _ _ _
    _ = 0 := this
