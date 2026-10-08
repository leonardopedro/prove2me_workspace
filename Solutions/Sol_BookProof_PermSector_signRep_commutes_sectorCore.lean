-- Generated from ChapterPermutationSectorEsa.lean — solution of BookProof.PermSector.signRep_commutes_sectorCore
import Mathlib
import Definitions.Def_ChapterPermutationSectorEsa
import Theorems.Thm_BookProof_PermSector_permOp_mem_sectorCore
import Theorems.Thm_BookProof_PermSector_restrictOp_sectorOp_permOp
import Theorems.Thm_BookProof_PermSector_signRep_mem_sectorCore
import Theorems.Thm_BookProof_TensorCore_sectorCore_le_sectorDom
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
        ⟨(signRep Hs n).act σ (x : (Hs.pow n).carrier),
          signRep_mem_sectorCore Hs D₂ D n σ _ x.2⟩
      = (signRep Hs n).act σ
          (restrictOp (sectorOp Hs D₂ A n) (sectorCore_le_sectorDom Hs D₂ D n) x) := by

  have hsplit : (⟨(signRep Hs n).act σ (x : (Hs.pow n).carrier),
        signRep_mem_sectorCore Hs D₂ D n σ _ x.2⟩ : sectorCore Hs D₂ D n)
      = ((Equiv.Perm.sign σ : ℤ) : ℂ) •
        (⟨permOp Hs n σ⁻¹ (x : (Hs.pow n).carrier),
          permOp_mem_sectorCore Hs D₂ D n σ⁻¹ x.2⟩ : sectorCore Hs D₂ D n) := by
    apply Subtype.ext
    rfl
  rw [hsplit, map_smul, restrictOp_sectorOp_permOp Hs D₂ A D n σ⁻¹ x]
  rfl
