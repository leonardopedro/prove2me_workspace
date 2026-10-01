-- Generated from ChapterHermiteFunctions.lean — solution of BookProof.HermiteCore.gaussH_sq
import Mathlib
import Definitions.Def_ChapterHermiteFunctions
open BookProof.HermiteCore




open MeasureTheory Polynomial Filter Topology FourierTransform SchwartzMap

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (x : ℝ) : gaussH x * gaussH x = gaussW x := by

  rw [gaussH, gaussW, ← Real.exp_add]; ring

t
