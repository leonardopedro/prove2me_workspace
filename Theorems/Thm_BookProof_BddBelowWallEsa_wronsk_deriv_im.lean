-- Generated from ChapterBddBelowWallEsa.lean — theorem BookProof.BddBelowWallEsa.wronsk_deriv_im
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterScalaronCoreEsa
import Definitions.Def_ChapterScalaronWallEsa
import Definitions.Def_ChapterWeakSecondDerivative
import Mathlib
import Definitions.Def_ChapterBddBelowWallEsa
import Definitions.Def_ChapterA4
open BookProof.BddBelowWallEsa

variable {V : ℝ → ℝ} {z : ℂ} {W W' : ℝ → ℂ}



open MeasureTheory Metric Filter Topology Set
open BookProof.FarisLavine BookProof.ScalaronEsa BookProof.ScalaronWallEsa
open BookProof.WallDeficiencyObstruction BookProof.WeakSecondDeriv

noncomputable section

theorem BookProof.BddBelowWallEsa.wronsk_deriv_im (x : ℝ) :
    ((starRingEnd ℂ) (W' x) * W' x
        + (starRingEnd ℂ) (W x) * ((((V x : ℝ) : ℂ) - z) * W x)).im
      = -z.im * ‖W x‖ ^ 2 := by sorry
