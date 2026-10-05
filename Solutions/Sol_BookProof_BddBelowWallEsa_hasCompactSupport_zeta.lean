-- Generated from ChapterBddBelowWallEsa.lean — solution of BookProof.BddBelowWallEsa.hasCompactSupport_zeta
import Mathlib
import Definitions.Def_ChapterBddBelowWallEsa
import Theorems.Thm_BookProof_BddBelowWallEsa_bumpG_zero
open BookProof.BddBelowWallEsa




open MeasureTheory Metric Filter Topology Set
open BookProof.FarisLavine BookProof.ScalaronEsa BookProof.ScalaronWallEsa
open BookProof.WallDeficiencyObstruction BookProof.WeakSecondDeriv

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution {r : ℝ} (hr : 0 < r) : HasCompactSupport (zeta r) := by

  apply HasCompactSupport.intro (isCompact_Icc (a := -(2 * r)) (b := 2 * r))
  intro x hx
  refine bumpG_zero ?_
  simp only [Set.mem_Icc, not_and_or, not_le] at hx
  rw [abs_div, abs_of_pos hr, le_div_iff₀ hr]
  rcases hx with h | h
  · rw [abs_of_nonpos (by linarith)]; linarith
  · rw [abs_of_nonneg (by linarith)]; linarith
