-- Generated from ChapterQgBrstCompleted.lean — solution of BookProof.QgBrstCompleted.wshift_norm_eq
import Mathlib
import Definitions.Def_ChapterQgBrstCompleted
open BookProof.QgBrstCompleted




open scoped ENNReal
open BookProof BookProof.QuantumGravityFock BookProof.BrstReducedTransfer

noncomputable section

variable {ι : Type*}
variable (w : ι → ℂ) (e : ι → ι) (hw : ∀ i, ‖w i‖ ≤ 1) (hinj : Set.InjOn e {i | w i ≠ 0})

set_option maxHeartbeats 1000000 in
theorem solution (hw1 : ∀ i, ‖w i‖ = 1) (hid : e = id) (f : L2 ι) :
    ‖wshift w e hw hinj f‖ = ‖f‖ := by

  have hp : (0 : ℝ) < ((2 : ℝ≥0∞)).toReal := by norm_num
  have h1 := lp.norm_rpow_eq_tsum hp (wshift w e hw hinj f)
  have h2 := lp.norm_rpow_eq_tsum hp f
  rw [show ((2 : ℝ≥0∞)).toReal = 2 by norm_num] at h1 h2
  have hpt : ∀ i, ‖(wshift w e hw hinj f) i‖ ^ (2 : ℝ) = ‖f i‖ ^ (2 : ℝ) := by
    intro i
    rw [wshift_apply, norm_mul, hw1, one_mul, hid, id_eq]
  refine le_antisymm (le_of_rpow_two_le (norm_nonneg f) ?_)
    (le_of_rpow_two_le (norm_nonneg _) ?_)
  · rw [h1, h2]; exact le_of_eq (tsum_congr hpt)
  · rw [h1, h2]; exact le_of_eq (tsum_congr fun i => (hpt i).symm)
