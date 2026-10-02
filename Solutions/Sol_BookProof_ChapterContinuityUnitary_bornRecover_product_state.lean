-- Generated from ChapterContinuityUnitary.lean — solution of BookProof.ChapterContinuityUnitary.bornRecover_product_state
import Mathlib
import Definitions.Def_ChapterContinuityUnitary
import Theorems.Thm_BookProof_ChapterContinuityUnitary_tensorIsom_tmul
open BookProof.ChapterContinuityUnitary



open scoped BigOperators Matrix TensorProduct


variable {N : ℕ} [NeZero N]

variable {N : ℕ} [NeZero N]
variable {X : Type*}

set_option maxHeartbeats 1000000 in
theorem solution (f : X → ℂ) (e0 : ZMod N → ℂ)
    (hf : ∀ x, ‖f x‖ = 1) (he0 : ∑ z, ‖e0 z‖ ^ 2 = 1)
    (v : X → (ZMod N → ℝ)) (t : ℝ) (x : X) :
    bornRecover (v x) t (fun z => productState X f e0 (x, z)) Finset.univ = 1 := by

  refine bornRecover_univ _ _ _ ?_
  have hslice : ∀ z, ‖productState X f e0 (x, z)‖ ^ 2 = ‖e0 z‖ ^ 2 := by
    intro z
    simp [productState, hf x]
  simp only [hslice]
  exact he0
