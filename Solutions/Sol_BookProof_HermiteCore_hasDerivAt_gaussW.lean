-- Generated from ChapterHermiteFunctions.lean — solution of BookProof.HermiteCore.hasDerivAt_gaussW
import Mathlib
import Definitions.Def_ChapterHermiteFunctions
open BookProof.HermiteCore




open MeasureTheory Polynomial Filter Topology FourierTransform SchwartzMap

noncomputable section

set_option maxHeartbeats 1000000 in
orem hasDerivAt_gaussW (x : ℝ) : HasDerivAt gaussW (-x * gaussW x) x := by

  have h : HasDerivAt (fun y : ℝ => -y ^ 2 / 2) (-x) x := by
    have h0 : HasDerivAt (fun y : ℝ => -y ^ 2 / 2) (-(2 * x) / 2) x := by
      simpa using ((hasDerivAt_pow 2 x).neg).div_co
