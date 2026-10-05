-- Generated from ChapterTwoParticleSectorEsa.lean — solution of BookProof.TwoParticleSector.tensorSquare_induction
import Mathlib
import Definitions.Def_ChapterTwoParticleSectorEsa
open BookProof.TwoParticleSector




open scoped TensorProduct
open BookProof.FarisLavine BookProof.GraphCore BookProof.ReducedEsa BookProof.TensorCore

noncomputable section

variable (X : Type) [NormedAddCommGroup X] [InnerProductSpace ℂ X]
variable {X}
variable (Hs : IPSpace) (D₂ : Submodule ℂ Hs.carrier)

set_option maxHeartbeats 1000000 in
theorem solution {Y : Type} [NormedAddCommGroup Y] [InnerProductSpace ℂ Y]
    {P : Y ⊗[ℂ] (Y ⊗[ℂ] ℂ) → Prop} (hzero : P 0)
    (htmul : ∀ (x y : Y) (c : ℂ), P (x ⊗ₜ[ℂ] (y ⊗ₜ[ℂ] c)))
    (hadd : ∀ u v, P u → P v → P (u + v)) (t : Y ⊗[ℂ] (Y ⊗[ℂ] ℂ)) : P t := by

  induction t using TensorProduct.induction_on with
  | zero => exact hzero
  | tmul x b =>
      induction b using TensorProduct.induction_on with
      | zero => simpa using hzero
      | tmul y c => exact htmul x y c
      | add u v hu hv => rw [TensorProduct.tmul_add]; exact hadd _ _ hu hv
  | add u v hu hv => exact hadd _ _ hu hv
