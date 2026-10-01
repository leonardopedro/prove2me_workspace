-- Generated from ChapterHermiteFunctions.lean — solution of BookProof.HermiteCore.hermiteR_one
import Mathlib
import Definitions.Def_ChapterHermiteFunctions
open BookProof.HermiteCore




open MeasureTheory Polynomial Filter Topology FourierTransform SchwartzMap

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution : hermiteR 1 = X := by

  simp [hermiteR]
