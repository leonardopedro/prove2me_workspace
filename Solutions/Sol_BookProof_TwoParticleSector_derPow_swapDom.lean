-- Generated from ChapterTwoParticleSectorEsa.lean — solution of BookProof.TwoParticleSector.derPow_swapDom
import Mathlib
import Definitions.Def_ChapterTwoParticleSectorEsa
import Theorems.Thm_BookProof_TwoParticleSector_tensorSquare_induction
import Theorems.Thm_BookProof_TwoParticleSector_derPow_two_tmul
open BookProof.TwoParticleSector




open scoped TensorProduct
open BookProof.FarisLavine BookProof.GraphCore BookProof.ReducedEsa BookProof.TensorCore

noncomputable section

variable (X : Type) [NormedAddCommGroup X] [InnerProductSpace ℂ X]
variable {X}
variable (Hs : IPSpace) (D₂ : Submodule ℂ Hs.carrier)
variable (A : D₂ →ₗ[ℂ] Hs.carrier)

set_option maxHeartbeats 1000000 in
theorem solution (t : ((domSpace Hs D₂).pow 2).carrier) :
    derPow Hs D₂ A 2 (swapDom Hs D₂ t) = swapH Hs (derPow Hs D₂ A 2 t) := by

  refine tensorSquare_induction (Y := (D₂ : Type))
    (P := fun t => derPow Hs D₂ A 2 (swapDom Hs D₂ t) = swapH Hs (derPow Hs D₂ A 2 t))
    ?_ ?_ ?_ t
  · simp
  · intro a b c
    rw [swapDom_tmul, derPow_two_tmul, derPow_two_tmul]
    rw [map_add, swapH_tmul, swapH_tmul]
    abel
  · intro u v hu hv
    simp [map_add, hu, hv]
