-- Generated from ChapterBddBelowWallEsa.lean — solution of BookProof.BddBelowWallEsa.hasDerivAt_zeta
import Mathlib
import Theorems.Thm_BookProof_BddBelowWallEsa_hasDerivAt_bumpG
open BookProof.BddBelowWallEsa




open MeasureTheory Metric Filter Topology Set
open BookProof.FarisLavine BookProof.ScalaronEsa BookProof.ScalaronWallEsa
open BookProof.WallDeficiencyObstruction BookProof.WeakSecondDeriv

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (r : ℝ) (x : ℝ) :
    @HasDerivAt ℝ _ ℝ
      DenselyNormedField.toNontriviallyNormedField.toDivisionRing.toAddCommGroup
      ((NormedAlgebra.toNormedSpace ℝ).toModule)
      _ _ (zeta r) (zeta' r x) x := by

  have h := (hasDerivAt_bumpG (x / r)).comp x ((hasDerivAt_id x).div_const r)
  convert h using 1
  · funext y; simp [zeta, Function.comp_apply, id_eq]
  · simp [zeta', div_eq_mul_inv]
