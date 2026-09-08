-- Generated from ChapterHermiteFunctions.lean — solution of BookProof.HermiteCore.hasDerivAt_hermiteFun
import Mathlib
import Definitions.Def_ChapterHermiteFunctions
import Theorems.Thm_BookProof_HermiteCore_hasDerivAt_gaussH
open BookProof.HermiteCore









open MeasureTheory Polynomial Filter Topology FourierTransform SchwartzMap

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (n : ℕ) (x : ℝ) :
    HasDerivAt (hermiteFun n)
      (((derivative (hermiteR n)).eval x - x / 2 * (hermiteR n).eval x) * gaussH x) x := by

  have h := ((hermiteR n).hasDerivAt x).mul (hasDerivAt_gaussH x)
  convert h using 1
  ring
