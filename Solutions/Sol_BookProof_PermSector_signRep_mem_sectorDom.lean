-- Generated from ChapterPermutationSectorEsa.lean — solution of BookProof.PermSector.signRep_mem_sectorDom
import Mathlib
import Definitions.Def_ChapterPermutationSectorEsa
import Theorems.Thm_BookProof_PermSector_permOp_mem_sectorDom
open BookProof.PermSector




open scoped TensorProduct
open BookProof.FarisLavine BookProof.GraphCore BookProof.ReducedEsa BookProof.TensorCore
open BookProof.GroupAverage BookProof.TensorPerm

noncomputable section

variable (Hs : IPSpace) (D₂ : Submodule ℂ Hs.carrier) (A : D₂ →ₗ[ℂ] Hs.carrier)
  (D : Submodule ℂ Hs.carrier)

set_option maxHeartbeats 1000000 in
theorem solution (n : ℕ) (σ : Equiv.Perm (Fin n)) (x : (Hs.pow n).carrier)
    (hx : x ∈ sectorDom Hs D₂ n) : (signRep Hs n).act σ x ∈ sectorDom Hs D₂ n := Submodule.smul_mem _ _ (permOp_mem_sectorDom Hs D₂ n σ⁻¹ hx)
