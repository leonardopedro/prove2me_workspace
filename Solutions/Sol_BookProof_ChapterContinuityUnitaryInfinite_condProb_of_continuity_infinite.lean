-- Generated from ChapterContinuityUnitaryInfinite.lean — solution of BookProof.ChapterContinuityUnitaryInfinite.condProb_of_continuity_infinite
import Mathlib
import Definitions.Def_ChapterContinuityUnitaryInfinite
import Theorems.Thm_BookProof_ChapterContinuityUnitaryInfinite_bornPMF_apply
open BookProof.ChapterContinuityUnitaryInfinite



open scoped ENNReal InnerProductSpace

set_option maxHeartbeats 1000000 in
nPMF_apply (v : LinfZ) (t : ℝ) (psi : L2Z) (hpsi : ‖psi‖ = 1) (z : ℤ) :
    bornPMF v t psi hpsi z
      = ENNReal.ofReal (‖((evolvedState v t psi : L2Z) : ℤ → ℂ) z‖ ^ 2) := rfl

theorem solution (v : X → LinfZ) (t : ℝ) (psi : X → L2Z)
    (hp :=
  si : ∀ x, ‖psi x‖ = 1) (x : X) :
      (∑' z : ℤ, bornPMF (v x) t (psi x) (hpsi x) z) = 1 ∧
        ∀ B : Finset ℤ,
          ∑ z ∈ B, bornPMF (v x) t (psi x) (hpsi x) z
            = ENNReal.ofReal (bornR
