-- Generated from ChapterBddBelowWallEsa.lean — solution of BookProof.BddBelowWallEsa.hasCompactSupport_zeta'_sq
import Mathlib
import Theorems.Thm_BookProof_BddBelowWallEsa_hasCompactSupport_zeta_prime
open BookProof.BddBelowWallEsa




open MeasureTheory Metric Filter Topology Set
open BookProof.FarisLavine BookProof.ScalaronEsa BookProof.ScalaronWallEsa
open BookProof.WallDeficiencyObstruction BookProof.WeakSecondDeriv

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution {r : ℝ} (hr : 0 < r) :
    @HasCompactSupport ℝ ℝ _ instMulZeroClassOfSemiring.toZero
      (fun x => (zeta' r x) ^ 2) := by

  have h := (hasCompactSupport_zeta_prime hr).mul_right (f' := zeta' r)
  convert h using 1
  funext y; simp [pow_two]
