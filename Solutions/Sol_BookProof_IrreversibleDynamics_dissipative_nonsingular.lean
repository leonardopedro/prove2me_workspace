-- Generated from ChapterIrreversibleDynamics.lean — solution of BookProof.IrreversibleDynamics.dissipative_nonsingular
import Mathlib
import Definitions.Def_ChapterIrreversibleDynamics
import Theorems.Thm_BookProof_IrreversibleDynamics_dissipative_volume_image
open BookProof.IrreversibleDynamics




open MeasureTheory Function Set
open scoped ENNReal

set_option maxHeartbeats 1000000 in
theorem solution {A : Set ℝ} (h : 0 < volume A) :
    0 < volume (dissipative '' A) := by

  rw [dissipative_volume_image]
  simp [ENNReal.div_pos_iff, h.ne']
