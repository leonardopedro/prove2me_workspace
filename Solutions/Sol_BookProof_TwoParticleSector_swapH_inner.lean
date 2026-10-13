-- Generated from ChapterTwoParticleSectorEsa.lean — solution of BookProof.TwoParticleSector.swapH_inner
import Mathlib
import Definitions.Def_ChapterTwoParticleSectorEsa
import Theorems.Thm_BookProof_TwoParticleSector_swapTwo_inner
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterGraphCoreTransfer
import Definitions.Def_ChapterReducingSubspaceEsa
import Definitions.Def_ChapterTensorGraphCore
open BookProof.TwoParticleSector




open scoped TensorProduct
open BookProof.FarisLavine BookProof.GraphCore BookProof.ReducedEsa BookProof.TensorCore

noncomputable section

variable (X : Type) [NormedAddCommGroup X] [InnerProductSpace ℂ X]
variable {X}
variable (Hs : IPSpace) (D₂ : Submodule ℂ Hs.carrier)

set_option maxHeartbeats 1000000 in
theorem solution (t s : (Hs.pow 2).carrier) :
    (inner ℂ (swapH Hs t) (swapH Hs s) : ℂ) = inner ℂ t s := swapTwo_inner t s
