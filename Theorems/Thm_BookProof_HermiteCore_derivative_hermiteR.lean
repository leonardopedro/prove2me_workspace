-- Generated from ChapterHermiteFunctions.lean — theorem BookProof.HermiteCore.derivative_hermiteR
import Mathlib
import Definitions.Def_ChapterHermiteFunctions
open BookProof.HermiteCore



open MeasureTheory Polynomial Filter Topology FourierTransform SchwartzMap

noncomputable section

theorem BookProof.HermiteCore.derivative_hermiteR (n : ℕ) :
    derivative (hermiteR (n + 1)) = C ((n : ℝ) + 1) * hermiteR n := by sorry
