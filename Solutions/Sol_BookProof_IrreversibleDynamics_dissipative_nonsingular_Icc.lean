-- Generated from ChapterIrreversibleDynamics.lean — solution of BookProof.IrreversibleDynamics.dissipative_nonsingular_Icc
import Mathlib
import Definitions.Def_ChapterIrreversibleDynamics
import Theorems.Thm_BookProof_IrreversibleDynamics_dissipative_volume_Icc
open BookProof.IrreversibleDynamics




open MeasureTheory Function Set
open scoped ENNReal

set_option maxHeartbeats 1000000 in
theorem solution {a b : ℝ} (h : a < b) :
    0 < volume (dissipative '' Set.Icc a b) := by

  rw [dissipative_volume_Icc]
  simp only [ENNReal.ofReal_pos]
  linarith
