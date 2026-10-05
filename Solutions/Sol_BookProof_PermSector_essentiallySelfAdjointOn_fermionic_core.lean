-- Generated from ChapterPermutationSectorEsa.lean — solution of BookProof.PermSector.essentiallySelfAdjointOn_fermionic_core
import Mathlib
import Definitions.Def_ChapterPermutationSectorEsa
import Theorems.Thm_BookProof_PermSector_isReducingProjection_fermionicProj
import Theorems.Thm_BookProof_PermSector_signRep_mem_sectorCore
import Theorems.Thm_BookProof_PermSector_signRep_commutes_sectorCore
import Theorems.Thm_BookProof_GroupAverage_UnitaryRep_avgProj_mem
import Theorems.Thm_BookProof_GroupAverage_UnitaryRep_commutes_avgProj
import Theorems.Thm_BookProof_ReducedEsa_essentiallySelfAdjointOn_red
open BookProof.PermSector




open scoped TensorProduct
open BookProof.FarisLavine BookProof.GraphCore BookProof.ReducedEsa BookProof.TensorCore
open BookProof.GroupAverage BookProof.TensorPerm

noncomputable section

variable (Hs : IPSpace) (D₂ : Submodule ℂ Hs.carrier) (A : D₂ →ₗ[ℂ] Hs.carrier)
  (D : Submodule ℂ Hs.carrier)

set_option maxHeartbeats 1000000 in
theorem solution (n : ℕ) (hcore : IsGraphCore D A)
    (hesa : EssentiallySelfAdjointOn (sectorDom Hs D₂ n) (sectorOp Hs D₂ A n)) :
    EssentiallySelfAdjointOn
      (redDom (fermionicProj Hs n) (sectorCore Hs D₂ D n))
      (redOp (restrictOp (sectorOp Hs D₂ A n) (sectorCore_le_sectorDom Hs D₂ D n))
        (isReducingProjection_fermionicProj Hs n)
        ((signRep Hs n).commutes_avgProj
          (hD := signRep_mem_sectorCore Hs D₂ D n)
          (signRep_commutes_sectorCore Hs D₂ A D n))) :=
  essentiallySelfAdjointOn_red _ _
      (essentiallySelfAdjointOn_sectorCore Hs D₂ A D hcore n hesa)
