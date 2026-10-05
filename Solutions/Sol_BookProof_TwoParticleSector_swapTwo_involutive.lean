-- Generated from ChapterTwoParticleSectorEsa.lean — solution of BookProof.TwoParticleSector.swapTwo_involutive
import Mathlib
import Definitions.Def_ChapterTwoParticleSectorEsa
open BookProof.TwoParticleSector




open scoped TensorProduct
open BookProof.FarisLavine BookProof.GraphCore BookProof.ReducedEsa BookProof.TensorCore

noncomputable section

variable (X : Type) [NormedAddCommGroup X] [InnerProductSpace ℂ X]
variable {X}

set_option maxHeartbeats 1000000 in
theorem solution (t : X ⊗[ℂ] (X ⊗[ℂ] ℂ)) : swapTwo X (swapTwo X t) = t := by

  induction t using TensorProduct.induction_on with
  | zero => simp
  | tmul x b =>
      induction b using TensorProduct.induction_on with
      | zero => simp
      | tmul y c => simp
      | add u v hu hv => simp [TensorProduct.tmul_add, hu, hv]
  | add u v hu hv => simp [hu, hv]
