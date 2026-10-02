-- Generated from ChapterUnitaryTransport.lean — solution of BookProof.ChapterUnitaryTransport.transport_adjointDomain
import Mathlib
import Definitions.Def_ChapterUnitaryTransport
import Theorems.Thm_BookProof_ChapterUnitaryTransport_inner_map_symm
import Theorems.Thm_BookProof_ChapterUnitaryTransport_transportEquiv_coe
import Theorems.Thm_BookProof_ChapterUnitaryTransport_transportOp_apply
open BookProof.ChapterUnitaryTransport



open scoped InnerProductSpace


variable {H K : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]
  [NormedAddCommGroup K] [InnerProductSpace ℂ K]

variable {H K : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]
  [NormedAddCommGroup K] [InnerProductSpace ℂ K]

set_option maxHeartbeats 1000000 in
theorem solution (W : H ≃ₗᵢ[ℂ] K) (D : Submodule ℂ H) (A : D →ₗ[ℂ] H) :
    adjointDomain (transportDomain W D) (transportOp W D A) = W '' adjointDomain D A := by

  ext phi'
  constructor
  · rintro ⟨eta', h⟩
    refine ⟨W.symm phi', ⟨W.symm eta', fun psi => ?_⟩, by simp⟩
    have hkey := h (transportEquiv W D psi)
    rw [transportOp_apply, inner_map_symm] at hkey
    rw [hkey, transportEquiv_coe, inner_map_symm]
  · rintro ⟨phi, ⟨eta, h⟩, rfl⟩
    refine ⟨W eta, fun y => ?_⟩
    obtain ⟨a, rfl⟩ := (transportEquiv W D).surjective y
    rw [transportOp_apply, transportEquiv_coe, W.inner_map_map, W.inner_map_map]
    exact h a
