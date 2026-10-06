-- Generated from ChapterTwoParticleSectorEsa.lean — solution of BookProof.TwoParticleSector.restrictOp_sectorOp_swapH
import Mathlib
import Definitions.Def_ChapterTwoParticleSectorEsa
import Theorems.Thm_BookProof_TwoParticleSector_swapH_mem_sectorCore
import Theorems.Thm_BookProof_TwoParticleSector_sectorOp_swapH
import Theorems.Thm_BookProof_TensorCore_sectorCore_le_sectorDom
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
theorem solution (x : sectorCore Hs D₂ D 2) :
    restrictOp (sectorOp Hs D₂ A 2) (sectorCore_le_sectorDom Hs D₂ D 2)
        ⟨swapH Hs (x : (Hs.pow 2).carrier), swapH_mem_sectorCore Hs D₂ D x.2⟩
      = swapH Hs (restrictOp (sectorOp Hs D₂ A 2) (sectorCore_le_sectorDom Hs D₂ D 2) x) := by

  simpa using
    sectorOp_swapH Hs D₂ A ⟨(x : (Hs.pow 2).carrier), sectorCore_le_sectorDom Hs D₂ D 2 x.2⟩
