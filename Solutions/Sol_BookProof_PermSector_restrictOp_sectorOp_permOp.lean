-- Generated from ChapterPermutationSectorEsa.lean — solution of BookProof.PermSector.restrictOp_sectorOp_permOp
import Mathlib
import Definitions.Def_ChapterPermutationSectorEsa
import Theorems.Thm_BookProof_PermSector_permOp_mem_sectorCore
import Theorems.Thm_BookProof_PermSector_sectorOp_permOp
open BookProof.PermSector




open scoped TensorProduct
open BookProof.FarisLavine BookProof.GraphCore BookProof.ReducedEsa BookProof.TensorCore
open BookProof.GroupAverage BookProof.TensorPerm

noncomputable section

variable (Hs : IPSpace) (D₂ : Submodule ℂ Hs.carrier) (A : D₂ →ₗ[ℂ] Hs.carrier)
  (D : Submodule ℂ Hs.carrier)

set_option maxHeartbeats 1000000 in
theorem solution (n : ℕ) (σ : Equiv.Perm (Fin n))
    (x : sectorCore Hs D₂ D n) :
    restrictOp (sectorOp Hs D₂ A n) (sectorCore_le_sectorDom Hs D₂ D n)
        ⟨permOp Hs n σ (x : (Hs.pow n).carrier), permOp_mem_sectorCore Hs D₂ D n σ x.2⟩
      = permOp Hs n σ
          (restrictOp (sectorOp Hs D₂ A n) (sectorCore_le_sectorDom Hs D₂ D n) x) := by

  simpa using sectorOp_permOp Hs D₂ A n σ
    ⟨(x : (Hs.pow n).carrier), sectorCore_le_sectorDom Hs D₂ D n x.2⟩
