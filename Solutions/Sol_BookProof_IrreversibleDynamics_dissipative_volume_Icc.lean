-- Generated from ChapterIrreversibleDynamics.lean — solution of BookProof.IrreversibleDynamics.dissipative_volume_Icc
import Mathlib
import Definitions.Def_ChapterIrreversibleDynamics
import Theorems.Thm_BookProof_IrreversibleDynamics_dissipative_image_Icc
open BookProof.IrreversibleDynamics




open MeasureTheory Function Set
open scoped ENNReal

set_option maxHeartbeats 1000000 in
theorem solution (a b : ℝ) :
    volume (dissipative '' Set.Icc a b) = ENNReal.ofReal ((b - a) / 2) := by

  rw [dissipative_image_Icc, Real.volume_Icc]
  congr 1; ring
