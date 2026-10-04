-- Generated from ChapterBddBelowWallEsa.lean — theorem BookProof.BddBelowWallEsa.hasDerivAt_zeta
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterScalaronCoreEsa
import Definitions.Def_ChapterScalaronWallEsa
import Definitions.Def_ChapterWeakSecondDerivative
import Mathlib
import Definitions.Def_ChapterBddBelowWallEsa
import Definitions.Def_ChapterA4
open BookProof.BddBelowWallEsa



open MeasureTheory Metric Filter Topology Set
open BookProof.FarisLavine BookProof.ScalaronEsa BookProof.ScalaronWallEsa
open BookProof.WallDeficiencyObstruction BookProof.WeakSecondDeriv

noncomputable section

theorem BookProof.BddBelowWallEsa.hasDerivAt_zeta (r : ℝ) (x : ℝ) :
    @HasDerivAt ℝ _ ℝ
      DenselyNormedField.toNontriviallyNormedField.toDivisionRing.toAddCommGroup
      ((NormedAlgebra.toNormedSpace ℝ).toModule)
      _ _ (zeta r) (zeta' r x) x := by sorry
