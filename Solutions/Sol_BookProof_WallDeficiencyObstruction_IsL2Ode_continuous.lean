-- Generated from ChapterWallDeficiencyObstruction.lean — solution of BookProof.WallDeficiencyObstruction.IsL2Ode.continuous
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
    Continuous W := by

  obtain ⟨W', hW, -, -⟩ := h
  exact continuous_iff_continuousAt.2 fun x => (hW x).continuousAt
