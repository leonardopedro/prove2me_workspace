-- Generated from ChapterHermiteFunctions.lean — solution of BookProof.HermiteCore.gaussH_pos
import Mathlib
import Definitions.Def_ChapterHermiteFunctions
open BookProof.HermiteCore




open MeasureTheory Polynomial Filter Topology FourierTransform SchwartzMap

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (x : ℝ) : 0 < gaussH x := Real.exp_pos _
