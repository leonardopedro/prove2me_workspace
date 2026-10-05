-- Generated from ChapterBddBelowWallEsa.lean — solution of BookProof.BddBelowWallEsa.hasDerivAt_imWeighted
import Mathlib
import Definitions.Def_ChapterBddBelowWallEsa
import Theorems.Thm_BookProof_BddBelowWallEsa_hasDerivAt_zeta
import Theorems.Thm_BookProof_BddBelowWallEsa_hasDerivAt_wronsk
import Theorems.Thm_BookProof_BddBelowWallEsa_wronsk_deriv_im
open BookProof.BddBelowWallEsa




open MeasureTheory Metric Filter Topology Set
open BookProof.FarisLavine BookProof.ScalaronEsa BookProof.ScalaronWallEsa
open BookProof.WallDeficiencyObstruction BookProof.WeakSecondDeriv

noncomputable section

variable {V : ℝ → ℝ} {z : ℂ} {W W' : ℝ → ℂ}

set_option maxHeartbeats 1000000 in
theorem solution (hW : ∀ x, HasDerivAt W (W' x) x)
    (hW2 : ∀ x, HasDerivAt W' ((((V x : ℝ) : ℂ) - z) * W x) x) (r : ℝ) (x : ℝ) :
    @HasDerivAt ℝ _ ℝ
      DenselyNormedField.toNontriviallyNormedField.toDivisionRing.toAddCommGroup
      ((NormedAlgebra.toNormedSpace ℝ).toModule) _ _
      (fun y => (zeta r y) ^ 2 * ((starRingEnd ℂ) (W y) * W' y).im)
      (2 * zeta r x * zeta' r x * ((starRingEnd ℂ) (W x) * W' x).im
        + (zeta r x) ^ 2 * (-z.im * ‖W x‖ ^ 2)) x := by

  have hz2 : @HasDerivAt ℝ _ ℝ
      DenselyNormedField.toNontriviallyNormedField.toDivisionRing.toAddCommGroup
      ((NormedAlgebra.toNormedSpace ℝ).toModule)
      _ _ (fun y => (zeta r y) ^ 2) (2 * zeta r x * zeta' r x) x := by
    have h := (hasDerivAt_zeta r x).pow 2
    convert h using 1
    · funext y; rfl
    · simp [mul_comm, mul_assoc, mul_left_comm]
  have hP : HasDerivAt (fun y => ((starRingEnd ℂ) (W y) * W' y).im)
      (-z.im * ‖W x‖ ^ 2) x := by
    have h := Complex.imCLM.hasFDerivAt.comp_hasDerivAt x (hasDerivAt_wronsk hW hW2 x)
    simp only [Function.comp_def, Complex.imCLM_apply] at h
    rwa [wronsk_deriv_im (V := V) (z := z) (W := W) (W' := W') x] at h
  have hmul := hz2.mul hP
  convert hmul using 1
  · funext y; simp
