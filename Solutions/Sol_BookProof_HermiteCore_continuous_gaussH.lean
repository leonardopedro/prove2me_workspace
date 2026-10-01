-- Generated from ChapterHermiteFunctions.lean — solution of BookProof.HermiteCore.continuous_gaussH
import Mathlib
import Definitions.Def_ChapterHermiteFunctions
open BookProof.HermiteCore




open MeasureTheory Polynomial Filter Topology FourierTransform SchwartzMap

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution : Continuous gaussH := by

  unfold gaussH; fun_prop
