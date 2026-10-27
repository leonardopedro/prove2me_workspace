-- Generated from ChapterWallDeficiencyObstruction.lean — solution of BookProof.WallDeficiencyObstruction.contDiff_harmonicShiftedV
import Mathlib
import Definitions.Def_ChapterWallDeficiencyObstruction
open BookProof.WallDeficiencyObstruction




open MeasureTheory SchwartzMap Set
open BookProof.FarisLavine BookProof.StrichartzWave BookProof.ScalaronEsa
open BookProof.ScalaronWallEsa
open BookProof.WeakSecondDeriv

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution :
    ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) harmonicShiftedV := by

  have h : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) fun x : ℝ => x ^ 2 - 1 :=
    (contDiff_id.pow 2).sub contDiff_const
  exact h
