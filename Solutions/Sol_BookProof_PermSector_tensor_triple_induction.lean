-- Generated from ChapterPermutationSectorEsa.lean — solution of BookProof.PermSector.tensor_triple_induction
import Mathlib
import Definitions.Def_ChapterPermutationSectorEsa
open BookProof.PermSector




open scoped TensorProduct
open BookProof.FarisLavine BookProof.GraphCore BookProof.ReducedEsa BookProof.TensorCore
open BookProof.GroupAverage BookProof.TensorPerm

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution {X Y Z : Type*} [AddCommGroup X] [Module ℂ X]
    [AddCommGroup Y] [Module ℂ Y] [AddCommGroup Z] [Module ℂ Z]
    {P : X ⊗[ℂ] (Y ⊗[ℂ] Z) → Prop} (hzero : P 0)
    (htmul : ∀ (x : X) (y : Y) (z : Z), P (x ⊗ₜ[ℂ] (y ⊗ₜ[ℂ] z)))
    (hadd : ∀ u v, P u → P v → P (u + v)) (t : X ⊗[ℂ] (Y ⊗[ℂ] Z)) : P t := by

  induction t using TensorProduct.induction_on with
  | zero => exact hzero
  | tmul x b =>
      induction b using TensorProduct.induction_on with
      | zero => simpa using hzero
      | tmul y z => exact htmul x y z
      | add u v hu hv => rw [TensorProduct.tmul_add]; exact hadd _ _ hu hv
  | add u v hu hv => exact hadd _ _ hu hv
