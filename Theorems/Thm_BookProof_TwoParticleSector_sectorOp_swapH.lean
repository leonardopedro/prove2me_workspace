-- Generated from ChapterTwoParticleSectorEsa.lean — theorem BookProof.TwoParticleSector.sectorOp_swapH
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterGraphCoreTransfer
import Definitions.Def_ChapterReducingSubspaceEsa
import Mathlib
import Definitions.Def_ChapterTwoParticleSectorEsa
import Definitions.Def_ChapterTensorGraphCore
import Theorems.Thm_BookProof_TwoParticleSector_swapH_mem_sectorDom
open BookProof.TensorCore
open BookProof.TwoParticleSector



open scoped TensorProduct
open BookProof.FarisLavine BookProof.GraphCore BookProof.ReducedEsa BookProof.TensorCore

noncomputable section

variable (X : Type) [NormedAddCommGroup X] [InnerProductSpace ℂ X]
variable {X}
variable (Hs : IPSpace) (D₂ : Submodule ℂ Hs.carrier)
variable (A : D₂ →ₗ[ℂ] Hs.carrier)
variable (D : Submodule ℂ Hs.carrier)

theorem BookProof.TwoParticleSector.sectorOp_swapH (x : sectorDom Hs D₂ 2) :
    sectorOp Hs D₂ A 2 ⟨swapH Hs (x : (Hs.pow 2).carrier),
        swapH_mem_sectorDom Hs D₂ x.2⟩
      = swapH Hs (sectorOp Hs D₂ A 2 x) := by sorry
