-- Generated from ChapterPermutationSectorEsa.lean — solution of BookProof.PermSector.signRep_commutes_sectorDom
import Mathlib
import Definitions.Def_ChapterPermutationSectorEsa
import Theorems.Thm_BookProof_PermSector_permOp_mem_sectorDom
import Theorems.Thm_BookProof_PermSector_sectorOp_permOp
import Theorems.Thm_BookProof_PermSector_signRep_mem_sectorDom
open BookProof.PermSector




open scoped TensorProduct
open BookProof.FarisLavine BookProof.GraphCore BookProof.ReducedEsa BookProof.TensorCore
open BookProof.GroupAverage BookProof.TensorPerm

noncomputable section

variable (Hs : IPSpace) (D₂ : Submodule ℂ Hs.carrier) (A : D₂ →ₗ[ℂ] Hs.carrier)
  (D : Submodule ℂ Hs.carrier)

set_option maxHeartbeats 1000000 in
theorem solution (n : ℕ) (σ : Equiv.Perm (Fin n))
    (x : sectorDom Hs D₂ n) :
    sectorOp Hs D₂ A n ⟨(signRep Hs n).act σ (x : (Hs.pow n).carrier),
        signRep_mem_sectorDom Hs D₂ n σ _ x.2⟩
      = (signRep Hs n).act σ (sectorOp Hs D₂ A n x) := by

  have hsplit : (⟨(signRep Hs n).act σ (x : (Hs.pow n).carrier),
        signRep_mem_sectorDom Hs D₂ n σ _ x.2⟩ : sectorDom Hs D₂ n)
      = ((Equiv.Perm.sign σ : ℤ) : ℂ) •
        (⟨permOp Hs n σ⁻¹ (x : (Hs.pow n).carrier),
          permOp_mem_sectorDom Hs D₂ n σ⁻¹ x.2⟩ : sectorDom Hs D₂ n) := by
    apply Subtype.ext
    rfl
  rw [hsplit, map_smul, sectorOp_permOp Hs D₂ A n σ⁻¹ x]
  rfl
