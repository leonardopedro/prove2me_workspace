-- Generated from ChapterTwoParticleSectorEsa.lean — solution of BookProof.TwoParticleSector.essentiallySelfAdjointOn_bosonic
import Mathlib
import Definitions.Def_ChapterTwoParticleSectorEsa
import Theorems.Thm_BookProof_TwoParticleSector_swapH_mem_sectorDom
import Theorems.Thm_BookProof_TwoParticleSector_sectorOp_swapH
import Theorems.Thm_BookProof_TwoParticleSector_isReducingProjection_bosonicProj
import Theorems.Thm_BookProof_ReducedEsa_commutes_symProj
import Theorems.Thm_BookProof_ReducedEsa_essentiallySelfAdjointOn_red
import Theorems.Thm_BookProof_ReducedEsa_symProj_mem
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
      (redDom (bosonicProj Hs) (sectorDom Hs D₂ 2))
      (redOp (sectorOp Hs D₂ A 2) (isReducingProjection_bosonicProj Hs)
        (commutes_symProj (T := sectorOp Hs D₂ A 2)
          (hUD := fun _ hx => swapH_mem_sectorDom Hs D₂ hx) (sectorOp_swapH Hs D₂ A))) := essentiallySelfAdjointOn_red _ _ hesa
