-- Generated from ChapterContinuityUnitary.lean — theorem BookProof.ChapterContinuityUnitary.condProb_of_continuity
import Mathlib
import Definitions.Def_ChapterContinuityUnitary
open BookProof.ChapterContinuityUnitary

variable {N : ℕ} [NeZero N]
variable {X : Type*}


open scoped BigOperators Matrix TensorProduct



theorem BookProof.ChapterContinuityUnitary.condProb_of_continuity (v : X → (ZMod N → ℝ)) (t : ℝ)
    (psi : X → ZMod N → ℂ) (hpsi : ∀ x, ∑ z, ‖psi x z‖ ^ 2 = 1) (x : X) :
    (∑' z, bornPMF (v x) t (psi x) (hpsi x) z) = 1 ∧
      ∀ B : Finset (ZMod N),
        ∑ z ∈ B, bornPMF (v x) t (psi x) (hpsi x) z
          = ENNReal.ofReal (bornRecover (v x) t (psi x) B) := by sorry
