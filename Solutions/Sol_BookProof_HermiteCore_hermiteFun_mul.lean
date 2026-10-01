-- Generated from ChapterHermiteFunctions.lean — solution of BookProof.HermiteCore.hermiteFun_mul
import Mathlib
import Definitions.Def_ChapterHermiteFunctions
import Theorems.Thm_BookProof_HermiteCore_gaussH_sq
open BookProof.HermiteCore




open MeasureTheory Polynomial Filter Topology FourierTransform SchwartzMap

noncomputable section

set_option maxHeartbeats 1000000 in
x) e^{-x²/4}`. -/
def hermiteFun (n : ℕ) (x : ℝ) : ℝ := (hermiteR n).eval x * gauss :=
  H x
  
  theorem hermiteFun_mul (m n : ℕ) (x : ℝ) :
      herm
