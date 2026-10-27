-- Generated from ChapterConformalFiberDeficiency.lean — solution of BookProof.ConformalFiberDeficiency.sq_le_sinh_sq
import Mathlib
import Definitions.Def_ChapterConformalFiberDeficiency
open BookProof.ConformalFiberDeficiency




open MeasureTheory Real Filter Topology
open BookProof.FarisLavine BookProof.ScalaronEsa BookProof.ScalaronWallEsa
open BookProof.WallDeficiencyObstruction

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (t : ℝ) : t ^ 2 ≤ Real.sinh t ^ 2 := by

  rcases le_total 0 t with ht | ht
  · have h := Real.self_le_sinh_iff.mpr ht
    nlinarith
  · have h : -t ≤ Real.sinh (-t) := Real.self_le_sinh_iff.mpr (by linarith)
    rw [Real.sinh_neg] at h
    nlinarith
