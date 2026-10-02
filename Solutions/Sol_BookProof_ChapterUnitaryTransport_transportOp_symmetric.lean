-- Generated from ChapterUnitaryTransport.lean — solution of BookProof.ChapterUnitaryTransport.transportOp_symmetric
import Mathlib
import Definitions.Def_ChapterUnitaryTransport
import Theorems.Thm_BookProof_ChapterUnitaryTransport_transportOp_apply
open BookProof.ChapterUnitaryTransport



open scoped InnerProductSpace


variable {H K : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]
  [NormedAddCommGroup K] [InnerProductSpace ℂ K]

variable {H K : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]
  [NormedAddCommGroup K] [InnerProductSpace ℂ K]

set_option maxHeartbeats 1000000 in
theorem solution (W : H ≃ₗᵢ[ℂ] K) (D : Submodule ℂ H) (A : D →ₗ[ℂ] H)
    (hA : IsSymmetricOn D A) : IsSymmetricOn (transportDomain W D) (transportOp W D A) := by

  intro y z
  obtain ⟨a, rfl⟩ := (transportEquiv W D).surjective y
  obtain ⟨b, rfl⟩ := (transportEquiv W D).surjective z
  rw [transportOp_apply, transportOp_apply]
  simpa using hA a b
