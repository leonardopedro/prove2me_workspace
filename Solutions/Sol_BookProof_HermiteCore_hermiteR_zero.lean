-- Generated from ChapterHermiteFunctions.lean — solution of BookProof.HermiteCore.hermiteR_zero
import Mathlib
import Definitions.Def_ChapterHermiteFunctions
open BookProof.HermiteCore




open MeasureTheory Polynomial Filter Topology FourierTransform SchwartzMap

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution : hermiteR 0 = 1 := by

  simp [hermiteR, Polynomial.hermite_zero]
