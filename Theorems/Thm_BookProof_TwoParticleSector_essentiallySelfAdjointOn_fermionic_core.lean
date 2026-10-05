-- Generated from ChapterTwoParticleSectorEsa.lean — theorem BookProof.TwoParticleSector.essentiallySelfAdjointOn_fermionic_core
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterReducingSubspaceEsa
import Mathlib
import Definitions.Def_ChapterTwoParticleSectorEsa
import Definitions.Def_ChapterDirectSumEsa
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterGraphCoreTransfer
import Definitions.Def_ChapterTensorGraphCore
open BookProof.DirectSumEsa
open BookProof.GraphCore
open BookProof.TensorCore
open BookProof.TwoParticleSector

variable (X : Type) [NormedAddCommGroup X] [InnerProductSpace ℂ X]
variable {X}
variable (Hs : IPSpace) (D₂ : Submodule ℂ Hs.carrier)
variable (A : D₂ →ₗ[ℂ] Hs.carrier)
variable (D : Submodule ℂ Hs.carrier)



open scoped TensorProduct
open BookProof.FarisLavine BookProof.GraphCore BookProof.ReducedEsa BookProof.TensorCore

noncomputable section

theorem BookProof.TwoParticleSector.essentiallySelfAdjointOn_fermionic_core (hcore : IsGraphCore D A)
    (hesa : EssentiallySelfAdjointOn (sectorDom Hs D₂ 2) (sectorOp Hs D₂ A 2)) :
    EssentiallySelfAdjointOn
      (redDom (fermionicProj Hs) (sectorCore Hs D₂ D 2))
      (redOp (restrictOp (sectorOp Hs D₂ A 2) (sectorCore_le_sectorDom Hs D₂ D 2))
        (isReducingProjection_fermionicProj Hs)
        (commutes_asymProj
          (T := restrictOp (sectorOp Hs D₂ A 2) (sectorCore_le_sectorDom Hs D₂ D 2))
          (hUD := fun _ hx => swapH_mem_sectorCore Hs D₂ D hx)
          (restrictOp_sectorOp_swapH Hs D₂ A D))) := by sorry
