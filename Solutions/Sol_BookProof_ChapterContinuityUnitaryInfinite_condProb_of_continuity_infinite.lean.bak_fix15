-- Generated from ChapterContinuityUnitaryInfinite.lean — solution of BookProof.ChapterContinuityUnitaryInfinite.condProb_of_continuity_infinite
import Mathlib
import Definitions.Def_ChapterContinuityUnitaryInfinite
import Theorems.Thm_BookProof_ChapterContinuityUnitaryInfinite_bornPMF_apply
open BookProof.ChapterContinuityUnitaryInfinite



open scoped ENNReal InnerProductSpace

set_option maxHeartbeats 1000000 in
theorem solution (v : X → LinfZ) (t : ℝ) (psi : X → L2Z)
    (hpsi : ∀ x, ‖psi x‖ = 1) (x : X) :
    (∑' z : ℤ, bornPMF (v x) t (psi x) (hpsi x) z) = 1 ∧
      ∀ B : Finset ℤ,
        ∑ z ∈ B, bornPMF (v x) t (psi x) (hpsi x) z
          = ENNReal.ofReal (bornRecover (v x) t (psi x) B) := by

  refine ⟨(bornPMF (v x) t (psi x) (hpsi x)).tsum_coe, fun B => ?_⟩
  rw [bornRecover, ENNReal.ofReal_sum_of_nonneg (fun _ _ => by positivity)]
  exact Finset.sum_congr rfl fun z _ => bornPMF_apply _ _ _ _ z
