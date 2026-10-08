-- Generated from ChapterBddBelowWallEsa.lean — theorem BookProof.BddBelowWallEsa.wronsk_deriv_re
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterScalaronCoreEsa
import Definitions.Def_ChapterScalaronWallEsa
import Definitions.Def_ChapterWallDeficiencyObstruction
import Definitions.Def_ChapterWeakSecondDerivative
import Mathlib
import Definitions.Def_ChapterBddBelowWallEsa
open BookProof.BddBelowWallEsa



open MeasureTheory Metric Filter Topology Set
open BookProof.FarisLavine BookProof.ScalaronEsa BookProof.ScalaronWallEsa
open BookProof.WallDeficiencyObstruction BookProof.WeakSecondDeriv

noncomputable section

variable {V : ℝ → ℝ} {z : ℂ} {W W' : ℝ → ℂ}

theorem BookProof.BddBelowWallEsa.wronsk_deriv_re (x : ℝ) :
    ((starRingEnd ℂ) (W' x) * W' x
        + (starRingEnd ℂ) (W x) * ((((V x : ℝ) : ℂ) - z) * W x)).re
      = ‖W' x‖ ^ 2 + (V x - z.re) * ‖W x‖ ^ 2 := by sorry
