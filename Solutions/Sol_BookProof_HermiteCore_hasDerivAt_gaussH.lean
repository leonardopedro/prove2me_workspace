-- Generated from ChapterHermiteFunctions.lean — solution of BookProof.HermiteCore.hasDerivAt_gaussH
import Mathlib
import Definitions.Def_ChapterHermiteFunctions
open BookProof.HermiteCore




open MeasureTheory Polynomial Filter Topology FourierTransform SchwartzMap

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (x : ℝ) : HasDerivAt gaussH (-(x / 2) * gaussH x) x := by

  have h : HasDerivAt (fun y : ℝ => -y ^ 2 / 4) (-(x / 2)) x := by
    have h0 : HasDerivAt (fun y : ℝ => -y ^ 2 / 4) (-(2 * x) / 4) x := by
      simpa using ((hasDerivAt_pow 2 x).neg).div_const 4
    convert h0 using 1
    ring
  show HasDerivAt (fun y : ℝ => Real.exp (-y ^ 2 / 4)) (-(x / 2) * Real.exp (-x ^ 2 / 4)) x
  simpa [mul_comm] using h.exp
