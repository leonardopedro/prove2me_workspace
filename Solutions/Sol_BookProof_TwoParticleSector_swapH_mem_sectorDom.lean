-- Generated from ChapterTwoParticleSectorEsa.lean — solution of BookProof.TwoParticleSector.swapH_mem_sectorDom
import Mathlib
import Definitions.Def_ChapterTwoParticleSectorEsa
import Theorems.Thm_BookProof_TwoParticleSector_inclPow_swapDom
open BookProof.TwoParticleSector




open scoped TensorProduct
open BookProof.FarisLavine BookProof.GraphCore BookProof.ReducedEsa BookProof.TensorCore

noncomputable section

variable (X : Type) [NormedAddCommGroup X] [InnerProductSpace ℂ X]
variable {X}
variable (Hs : IPSpace) (D₂ : Submodule ℂ Hs.carrier)
variable (A : D₂ →ₗ[ℂ] Hs.carrier)

set_option maxHeartbeats 1000000 in
theorem solution {x : (Hs.pow 2).carrier} (hx : x ∈ sectorDom Hs D₂ 2) :
    swapH Hs x ∈ sectorDom Hs D₂ 2 := by

  obtain ⟨t, rfl⟩ := hx
  exact ⟨swapDom Hs D₂ t, inclPow_swapDom Hs D₂ t⟩
