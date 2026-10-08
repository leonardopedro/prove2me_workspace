-- Generated from ChapterTwoParticleSectorEsa.lean — theorem BookProof.TwoParticleSector.derPow_swapDom
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterGraphCoreTransfer
import Definitions.Def_ChapterReducingSubspaceEsa
import Mathlib
import Definitions.Def_ChapterTwoParticleSectorEsa
import Definitions.Def_ChapterTensorGraphCore
open BookProof.TensorCore
open BookProof.TwoParticleSector



open scoped TensorProduct
open BookProof.FarisLavine BookProof.GraphCore BookProof.ReducedEsa BookProof.TensorCore

noncomputable section

variable (X : Type) [NormedAddCommGroup X] [InnerProductSpace ℂ X]
variable {X}
variable (Hs : IPSpace) (D₂ : Submodule ℂ Hs.carrier)
variable (A : D₂ →ₗ[ℂ] Hs.carrier)

theorem BookProof.TwoParticleSector.derPow_swapDom (t : ((domSpace Hs D₂).pow 2).carrier) :
    derPow Hs D₂ A 2 (swapDom Hs D₂ t) = swapH Hs (derPow Hs D₂ A 2 t) := by sorry
