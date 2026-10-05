-- Generated from ChapterTwoParticleSectorEsa.lean — solution of BookProof.TwoParticleSector.inclPow_swapDom
import Mathlib
import Definitions.Def_ChapterTwoParticleSectorEsa
import Theorems.Thm_BookProof_TwoParticleSector_tensorSquare_induction
open BookProof.TwoParticleSector




open scoped TensorProduct
open BookProof.FarisLavine BookProof.GraphCore BookProof.ReducedEsa BookProof.TensorCore

noncomputable section

variable (X : Type) [NormedAddCommGroup X] [InnerProductSpace ℂ X]
variable {X}
variable (Hs : IPSpace) (D₂ : Submodule ℂ Hs.carrier)

set_option maxHeartbeats 1000000 in
theorem solution (t : ((domSpace Hs D₂).pow 2).carrier) :
    inclPow Hs D₂ 2 (swapDom Hs D₂ t) = swapH Hs (inclPow Hs D₂ 2 t) := by

  refine tensorSquare_induction (Y := (D₂ : Type))
    (P := fun t => inclPow Hs D₂ 2 (swapDom Hs D₂ t) = swapH Hs (inclPow Hs D₂ 2 t))
    ?_ ?_ ?_ t
  · simp
  · intro a b c
    have h1 : inclPow Hs D₂ 2 (a ⊗ₜ[ℂ] (b ⊗ₜ[ℂ] c) : ((domSpace Hs D₂).pow 2).carrier)
        = (a : Hs.carrier) ⊗ₜ[ℂ] ((b : Hs.carrier) ⊗ₜ[ℂ] c) := rfl
    have h2 : inclPow Hs D₂ 2 (b ⊗ₜ[ℂ] (a ⊗ₜ[ℂ] c) : ((domSpace Hs D₂).pow 2).carrier)
        = (b : Hs.carrier) ⊗ₜ[ℂ] ((a : Hs.carrier) ⊗ₜ[ℂ] c) := rfl
    rw [swapDom_tmul, h1, h2, swapH_tmul]
  · intro u v hu hv
    simp [map_add, hu, hv]
