-- Generated from ChapterBddBelowWallEsa.lean — theorem BookProof.BddBelowWallEsa.hasDerivAt_reWeighted
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

theorem BookProof.BddBelowWallEsa.hasDerivAt_reWeighted (hW : ∀ x, HasDerivAt W (W' x) x)
    (hW2 : ∀ x, HasDerivAt W' ((((V x : ℝ) : ℂ) - z) * W x) x) (r : ℝ) (x : ℝ) :
    @HasDerivAt ℝ _ ℝ
      DenselyNormedField.toNontriviallyNormedField.toDivisionRing.toAddCommGroup
      ((NormedAlgebra.toNormedSpace ℝ).toModule) _ _
      (fun y => (zeta r y) ^ 2 * ((starRingEnd ℂ) (W y) * W' y).re)
      (2 * zeta r x * zeta' r x * ((starRingEnd ℂ) (W x) * W' x).re
        + (zeta r x) ^ 2 * (‖W' x‖ ^ 2 + (V x - z.re) * ‖W x‖ ^ 2)) x := by sorry
