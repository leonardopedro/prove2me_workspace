-- Generated from ChapterTwoParticleSectorEsa.lean — solution of BookProof.TwoParticleSector.swapTwo_involutive
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
theorem solution (t : X ⊗[ℂ] (X ⊗[ℂ] ℂ)) : swapTwo X (swapTwo X t) = t := by
  -- Plain `simp` no longer closes the `zero` cases: the generic `map_zero` simp lemma needs a
  -- `ZeroHomClass` instance on `LinearIsometryEquiv` that current Mathlib no longer provides
  -- directly, so we invoke the `LinearIsometryEquiv`-specific lemma instead.
  have key : ∀ a : X ⊗[ℂ] (X ⊗[ℂ] ℂ), swapTwo X (swapTwo X a) = a := by
    intro a
    induction a using TensorProduct.induction_on with
    | zero => rw [LinearIsometryEquiv.map_zero, LinearIsometryEquiv.map_zero]
    | tmul x b =>
      induction b using TensorProduct.induction_on with
      | zero => simp only [TensorProduct.tmul_zero, LinearIsometryEquiv.map_zero]
      | tmul y c => simp only [swapTwo_tmul]
      | add u v hu hv => simp only [TensorProduct.tmul_add, map_add, hu, hv]
    | add u v hu hv => simp only [map_add, hu, hv]
  exact key t
