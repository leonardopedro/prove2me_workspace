-- Generated from ChapterHermiteFunctions.lean — solution of BookProof.HermiteCore.hermiteR_succ
import Mathlib
import Definitions.Def_ChapterHermiteFunctions
open BookProof.HermiteCore




open MeasureTheory Polynomial Filter Topology FourierTransform SchwartzMap

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (n : ℕ) :
    hermiteR (n + 1) = X * hermiteR n - derivative (hermiteR n) := by

  simp [hermiteR, Polynomial.hermite_succ, Polynomial.derivative_map]
