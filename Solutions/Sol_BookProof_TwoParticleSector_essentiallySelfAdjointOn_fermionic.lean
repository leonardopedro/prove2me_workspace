-- Generated from ChapterTwoParticleSectorEsa.lean — solution of BookProof.TwoParticleSector.essentiallySelfAdjointOn_fermionic
import Mathlib
import Definitions.Def_ChapterTwoParticleSectorEsa
import Theorems.Thm_BookProof_TwoParticleSector_swapH_mem_sectorDom
import Theorems.Thm_BookProof_TwoParticleSector_sectorOp_swapH
import Theorems.Thm_BookProof_TwoParticleSector_isReducingProjection_fermionicProj
import Theorems.Thm_BookProof_ReducedEsa_asymProj_mem
import Theorems.Thm_BookProof_ReducedEsa_commutes_asymProj
import Theorems.Thm_BookProof_ReducedEsa_essentiallySelfAdjointOn_red
open BookProof.TwoParticleSector




open scoped TensorProduct
open BookProof.FarisLavine BookProof.GraphCore BookProof.ReducedEsa BookProof.TensorCore

noncomputable section

variable (X : Type) [NormedAddCommGroup X] [InnerProductSpace ℂ X]
variable {X}
variable (Hs : IPSpace) (D₂ : Submodule ℂ Hs.carrier)
variable (A : D₂ →ₗ[ℂ] Hs.carrier)
variable (D : Submodule ℂ Hs.carrier)

set_option maxHeartbeats 1000000 in
theorem solution
    (hesa : EssentiallySelfAdjointOn (sectorDom Hs D₂ 2) (sectorOp Hs D₂ A 2)) :
    EssentiallySelfAdjointOn
      (redDom (fermionicProj Hs) (sectorDom Hs D₂ 2))
      (redOp (sectorOp Hs D₂ A 2) (isReducingProjection_fermionicProj Hs)
        (commutes_asymProj (T := sectorOp Hs D₂ A 2)
          (hUD := fun _ hx => swapH_mem_sectorDom Hs D₂ hx) (sectorOp_swapH Hs D₂ A))) := essentiallySelfAdjointOn_red _ _ hesa
