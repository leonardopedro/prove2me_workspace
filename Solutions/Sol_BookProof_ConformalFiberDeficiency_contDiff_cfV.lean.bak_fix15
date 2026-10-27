-- Generated from ChapterConformalFiberDeficiency.lean — solution of BookProof.ConformalFiberDeficiency.contDiff_cfV
import Mathlib
import Definitions.Def_ChapterConformalFiberDeficiency
open BookProof.ConformalFiberDeficiency




open MeasureTheory Real Filter Topology
open BookProof.FarisLavine BookProof.ScalaronEsa BookProof.ScalaronWallEsa
open BookProof.WallDeficiencyObstruction

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) cfV := by

  have hden : ∀ y : ℝ, 2 * Real.cosh (y / 2) ^ 2 ≠ 0 := by
    intro y
    have := Real.cosh_pos (y / 2)
    positivity
  have hcosh : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) fun y : ℝ => 2 * Real.cosh (y / 2) ^ 2 := by
    fun_prop
  have h1 : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞)
      fun y : ℝ => 1 / (2 * Real.cosh (y / 2) ^ 2) :=
    ContDiff.div contDiff_const hcosh hden
  have h2 : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) fun y : ℝ => (1 + Real.exp (-y)) ^ 2 := by
    fun_prop
  exact (contDiff_const.sub h1).sub h2
