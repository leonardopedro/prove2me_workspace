-- Generated from ChapterPermutationSectorEsa.lean — solution of BookProof.PermSector.permOp_mem_sectorCore
import Mathlib
import Definitions.Def_ChapterPermutationSectorEsa
import Theorems.Thm_BookProof_PermSector_inclPow_permOp
import Theorems.Thm_BookProof_PermSector_corePow_permOp
open BookProof.PermSector




open scoped TensorProduct
open BookProof.FarisLavine BookProof.GraphCore BookProof.ReducedEsa BookProof.TensorCore
open BookProof.GroupAverage BookProof.TensorPerm

noncomputable section

variable (Hs : IPSpace) (D₂ : Submodule ℂ Hs.carrier) (A : D₂ →ₗ[ℂ] Hs.carrier)
  (D : Submodule ℂ Hs.carrier)

set_option maxHeartbeats 1000000 in
theorem solution (n : ℕ) (σ : Equiv.Perm (Fin n)) {x : (Hs.pow n).carrier}
    (hx : x ∈ sectorCore Hs D₂ D n) : permOp Hs n σ x ∈ sectorCore Hs D₂ D n := by

  obtain ⟨t, ht, rfl⟩ := hx
  exact ⟨permOp (domSpace Hs D₂) n σ t, corePow_permOp Hs D₂ D n σ ht,
    inclPow_permOp Hs D₂ n σ t⟩
