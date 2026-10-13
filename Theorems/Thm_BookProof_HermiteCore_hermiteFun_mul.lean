-- Generated from ChapterHermiteFunctions.lean — theorem BookProof.HermiteCore.hermiteFun_mul
import Mathlib
import Definitions.Def_ChapterHermiteFunctions
open BookProof.HermiteCore



open MeasureTheory Polynomial Filter Topology FourierTransform SchwartzMap

noncomputable section

x) e^{-x²/4}`. -/

theorem BookProof.HermiteCore.hermiteFun_mul (m n : ℕ) (x : ℝ) :
    hermiteFun m x * hermiteFun n x = (hermiteR m * hermiteR n).eval x * gaussW x := by sorry
