-- Generated from ChapterBddBelowWallEsa.lean — solution of BookProof.BddBelowWallEsa.abs_zeta'_le
import Mathlib
import Theorems.Thm_BookProof_BddBelowWallEsa_abs_bumpG_prime_le
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterScalaronCoreEsa
import Definitions.Def_ChapterScalaronWallEsa
import Definitions.Def_ChapterWallDeficiencyObstruction
import Definitions.Def_ChapterWeakSecondDerivative
import Definitions.Def_ChapterBddBelowWallEsa
open BookProof.BddBelowWallEsa




open MeasureTheory Metric Filter Topology Set
open BookProof.FarisLavine BookProof.ScalaronEsa BookProof.ScalaronWallEsa
open BookProof.WallDeficiencyObstruction BookProof.WeakSecondDeriv

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution {r : ℝ} (hr : 0 < r) (x : ℝ) : |zeta' r x| ≤ bumpM / r := by

  rw [zeta', abs_div, abs_of_pos hr]
  exact div_le_div_of_nonneg_right (abs_bumpG'_le _) hr.le
