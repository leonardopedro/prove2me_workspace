-- Generated from ChapterPermutationSectorEsa.lean — solution of BookProof.PermSector.symmetricOn_bosonic
import Mathlib
import Definitions.Def_ChapterPermutationSectorEsa
import Theorems.Thm_BookProof_PermSector_isReducingProjection_bosonicProj
import Theorems.Thm_BookProof_PermSector_permRep_mem_sectorDom
import Theorems.Thm_BookProof_PermSector_permRep_commutes_sectorDom
import Theorems.Thm_BookProof_GroupAverage_UnitaryRep_avgProj_mem
import Theorems.Thm_BookProof_GroupAverage_UnitaryRep_commutes_avgProj
import Theorems.Thm_BookProof_ReducedEsa_symmetricOn_redOp
import Theorems.Thm_BookProof_TensorCore_symmetricOn_sectorOp
open BookProof.PermSector




open scoped TensorProduct
open BookProof.FarisLavine BookProof.GraphCore BookProof.ReducedEsa BookProof.TensorCore
open BookProof.GroupAverage BookProof.TensorPerm

noncomputable section

variable (Hs : IPSpace) (D₂ : Submodule ℂ Hs.carrier) (A : D₂ →ₗ[ℂ] Hs.carrier)
  (D : Submodule ℂ Hs.carrier)

set_option maxHeartbeats 1000000 in
theorem solution (n : ℕ) (hA : SymmetricOn D₂ A) :
    SymmetricOn (redDom (bosonicProj Hs n) (sectorDom Hs D₂ n))
      (redOp (sectorOp Hs D₂ A n) (isReducingProjection_bosonicProj Hs n)
        ((permRep Hs n).commutes_avgProj
          (hD := permRep_mem_sectorDom Hs D₂ n)
          (permRep_commutes_sectorDom Hs D₂ A n))) := symmetricOn_redOp _ _ (symmetricOn_sectorOp Hs D₂ A hA n)
