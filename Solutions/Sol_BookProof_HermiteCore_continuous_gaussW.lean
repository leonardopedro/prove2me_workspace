-- Generated from ChapterHermiteFunctions.lean — solution of BookProof.HermiteCore.continuous_gaussW
import Mathlib
import Definitions.Def_ChapterHermiteFunctions
open BookProof.HermiteCore









open MeasureTheory Polynomial Filter Topology FourierTransform SchwartzMap

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution : Continuous gaussW := by

  unfold gaussW; fun_prop
