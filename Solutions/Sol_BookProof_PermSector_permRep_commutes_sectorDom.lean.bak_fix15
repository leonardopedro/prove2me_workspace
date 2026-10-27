-- Generated from ChapterPermutationSectorEsa.lean — solution of BookProof.PermSector.permRep_commutes_sectorDom
import Mathlib
import Definitions.Def_ChapterPermutationSectorEsa
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
    (x : sectorDom Hs D₂ n) :
    sectorOp Hs D₂ A n ⟨(permRep Hs n).act σ (x : (Hs.pow n).carrier),
        permRep_mem_sectorDom Hs D₂ n σ _ x.2⟩
      = (permRep Hs n).act σ (sectorOp Hs D₂ A n x) := sectorOp_permOp Hs D₂ A n σ⁻¹ x
