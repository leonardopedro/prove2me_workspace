-- Generated from ChapterTwoParticleSectorEsa.lean — solution of BookProof.TwoParticleSector.swapTwo_inner
import Mathlib
import Definitions.Def_ChapterTwoParticleSectorEsa
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

set_option maxHeartbeats 1000000 in

theorem solution (t s : X ⊗[ℂ] (X ⊗[ℂ] ℂ)) :
    (inner ℂ (swapTwo X t) (swapTwo X s) : ℂ) = inner ℂ t s :=
  (swapTwo X).inner_map_map t s

/-! ## The swap on the two-particle space and on its domain -/
