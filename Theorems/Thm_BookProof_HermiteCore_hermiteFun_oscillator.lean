-- Generated from ChapterHermiteFunctions.lean — theorem BookProof.HermiteCore.hermiteFun_oscillator
import Mathlib
import Definitions.Def_ChapterHermiteFunctions
open BookProof.HermiteCore








open MeasureTheory Polynomial Filter Topology FourierTransform SchwartzMap

noncomputable section

theorem BookProof.HermiteCore.hermiteFun_oscillator (n : ℕ) (x : ℝ) :
    -(deriv (deriv (hermiteFun n)) x) + x ^ 2 / 4 * hermiteFun n x
      = ((n : ℝ) + 1 / 2) * hermiteFun n x := by sorry
