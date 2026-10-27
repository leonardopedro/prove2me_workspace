-- Generated from ChapterWallDeficiencyObstruction.lean — solution of BookProof.WallDeficiencyObstruction.IsL2Ode.memLp
import Mathlib
import Definitions.Def_ChapterWallDeficiencyObstruction
open BookProof.WallDeficiencyObstruction




open MeasureTheory SchwartzMap Set
open BookProof.FarisLavine BookProof.StrichartzWave BookProof.ScalaronEsa
open BookProof.ScalaronWallEsa
open BookProof.WeakSecondDeriv

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution {V : ℝ → ℝ} {z : ℂ} {W : ℝ → ℂ} (h : IsL2Ode V z W) :
    MemLp W 2 (volume : Measure ℝ) := by

  obtain ⟨-, -, -, hm⟩ := h
  exact hm
