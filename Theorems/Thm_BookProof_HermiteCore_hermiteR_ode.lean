-- Generated from ChapterHermiteFunctions.lean — theorem BookProof.HermiteCore.hermiteR_ode
import Mathlib
import Definitions.Def_ChapterHermiteFunctions
open BookProof.HermiteCore








open MeasureTheory Polynomial Filter Topology FourierTransform SchwartzMap

noncomputable section

theorem BookProof.HermiteCore.hermiteR_ode (n : ℕ) :
    derivative (derivative (hermiteR n)) - X * derivative (hermiteR n) + C (n : ℝ) * hermiteR n
      = 0 := by sorry
