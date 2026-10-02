-- Generated from ChapterContinuityUnitary.lean — theorem BookProof.ChapterContinuityUnitary.bornRecover_product_state
import Mathlib
import Definitions.Def_ChapterContinuityUnitary
open BookProof.ChapterContinuityUnitary

variable {N : ℕ} [NeZero N]
variable {X : Type*}


open scoped BigOperators Matrix TensorProduct



theorem BookProof.ChapterContinuityUnitary.bornRecover_product_state (f : X → ℂ) (e0 : ZMod N → ℂ)
    (hf : ∀ x, ‖f x‖ = 1) (he0 : ∑ z, ‖e0 z‖ ^ 2 = 1)
    (v : X → (ZMod N → ℝ)) (t : ℝ) (x : X) :
    bornRecover (v x) t (fun z => productState X f e0 (x, z)) Finset.univ = 1 := by sorry
