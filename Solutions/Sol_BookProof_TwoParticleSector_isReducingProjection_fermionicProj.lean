-- Generated from ChapterTwoParticleSectorEsa.lean — solution of BookProof.TwoParticleSector.isReducingProjection_fermionicProj
import Mathlib
import Definitions.Def_ChapterTwoParticleSectorEsa
import Theorems.Thm_BookProof_TwoParticleSector_swapH_inner
import Theorems.Thm_BookProof_TwoParticleSector_swapH_involutive
import Theorems.Thm_BookProof_ReducedEsa_isReducingProjection_asymProj
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
theorem solution : IsReducingProjection (fermionicProj Hs) :=
  isReducingProjection_asymProj (swapH_involutive Hs)
      (fun x y => swapH_inner Hs x y)
