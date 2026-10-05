-- Generated from ChapterPermutationSectorEsa.lean — solution of BookProof.PermSector.permRep_commutes_sectorCore
import Mathlib
import Definitions.Def_ChapterPermutationSectorEsa
import Theorems.Thm_BookProof_PermSector_restrictOp_sectorOp_permOp
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
        ⟨(permRep Hs n).act σ (x : (Hs.pow n).carrier),
          permRep_mem_sectorCore Hs D₂ D n σ _ x.2⟩
      = (permRep Hs n).act σ
          (restrictOp (sectorOp Hs D₂ A n) (sectorCore_le_sectorDom Hs D₂ D n) x) := restrictOp_sectorOp_permOp Hs D₂ A D n σ⁻¹ x
