-- Generated from ChapterTwoParticleSectorEsa.lean — theorem BookProof.TwoParticleSector.swapH_mem_sectorDom
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterGraphCoreTransfer
import Definitions.Def_ChapterReducingSubspaceEsa
import Mathlib
import Definitions.Def_ChapterTwoParticleSectorEsa
import Definitions.Def_ChapterTensorGraphCore
open BookProof.TensorCore
open BookProof.TwoParticleSector

variable (X : Type) [NormedAddCommGroup X] [InnerProductSpace ℂ X]
variable {X}
variable (Hs : IPSpace) (D₂ : Submodule ℂ Hs.carrier)
variable (A : D₂ →ₗ[ℂ] Hs.carrier)



open scoped TensorProduct
open BookProof.FarisLavine BookProof.GraphCore BookProof.ReducedEsa BookProof.TensorCore

noncomputable section

theorem BookProof.TwoParticleSector.swapH_mem_sectorDom {x : (Hs.pow 2).carrier} (hx : x ∈ sectorDom Hs D₂ 2) :
    swapH Hs x ∈ sectorDom Hs D₂ 2 := by sorry
