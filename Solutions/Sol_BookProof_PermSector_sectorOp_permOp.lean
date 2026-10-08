-- Generated from ChapterPermutationSectorEsa.lean — solution of BookProof.PermSector.sectorOp_permOp
import Mathlib
import Definitions.Def_ChapterPermutationSectorEsa
import Theorems.Thm_BookProof_PermSector_inclPow_permOp
import Theorems.Thm_BookProof_PermSector_derPow_permOp
import Theorems.Thm_BookProof_PermSector_permOp_mem_sectorDom
import Theorems.Thm_BookProof_TensorCore_sectorOp_apply
open BookProof.PermSector




open scoped TensorProduct
open BookProof.FarisLavine BookProof.GraphCore BookProof.ReducedEsa BookProof.TensorCore
open BookProof.GroupAverage BookProof.TensorPerm

noncomputable section

variable (Hs : IPSpace) (D₂ : Submodule ℂ Hs.carrier) (A : D₂ →ₗ[ℂ] Hs.carrier)
  (D : Submodule ℂ Hs.carrier)

set_option maxHeartbeats 1000000 in
theorem solution (n : ℕ) (σ : Equiv.Perm (Fin n)) (x : sectorDom Hs D₂ n) :
    sectorOp Hs D₂ A n ⟨permOp Hs n σ (x : (Hs.pow n).carrier),
        permOp_mem_sectorDom Hs D₂ n σ x.2⟩
      = permOp Hs n σ (sectorOp Hs D₂ A n x) := by

  obtain ⟨t, ht⟩ := x.2
  have hx : (x : (Hs.pow n).carrier) = inclPow Hs D₂ n t := ht.symm
  have hsw : permOp Hs n σ (x : (Hs.pow n).carrier)
      = inclPow Hs D₂ n (permOp (domSpace Hs D₂) n σ t) := by
    rw [inclPow_permOp, hx]
  rw [sectorOp_apply Hs D₂ A n _ _ hsw, sectorOp_apply Hs D₂ A n x t hx, derPow_permOp]
