-- Generated from ChapterContinuityUnitaryInfinite.lean — theorem BookProof.ChapterContinuityUnitaryInfinite.condProb_of_continuity_infinite
import Mathlib
import Definitions.Def_ChapterContinuityUnitaryInfinite
open BookProof.ChapterContinuityUnitaryInfinite


open scoped ENNReal InnerProductSpace

theorem BookProof.ChapterContinuityUnitaryInfinite.condProb_of_continuity_infinite (v : X → LinfZ) (t : ℝ) (psi : X → L2Z)
    (hpsi : ∀ x, ‖psi x‖ = 1) (x : X) :
    (∑' z : ℤ, bornPMF (v x) t (psi x) (hpsi x) z) = 1 ∧
      ∀ B : Finset ℤ,
        ∑ z ∈ B, bornPMF (v x) t (psi x) (hpsi x) z
          = ENNReal.ofReal (bornRecover (v x) t (psi x) B) := by sorry
