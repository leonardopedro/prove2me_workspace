-- Generated from ChapterUnitaryCompleteReducibility.lean — solution of BookProof.ChapterUnitaryCompleteReducibility.inv_mem_of_isInvariant
import Mathlib
import Definitions.Def_ChapterUnitaryCompleteReducibility
open BookProof.ChapterUnitaryCompleteReducibility




open Submodule

variable {G : Type*} [Group G] {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V]

variable {G : Type*} [Group G] {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V]

set_option maxHeartbeats 1000000 in
theorem solution {ρ : G →* (V ≃ₗᵢ[ℂ] V)} {W : Submodule ℂ V}
    (hW : IsInvariant ρ W) (g : G) {x : V} (hx : x ∈ W) : (ρ g).symm x ∈ W := by

  have h : ρ g⁻¹ x ∈ W := hW g⁻¹ x hx
  have hsymm : (ρ g).symm x = ρ g⁻¹ x := by simp [map_inv]
  rwa [hsymm]
