-- Generated from ChapterHermiteFunctions.lean — solution of BookProof.HermiteCore.hermiteBasis_apply
import Mathlib
import Definitions.Def_ChapterHermiteFunctions
open BookProof.HermiteCore









open MeasureTheory Polynomial Filter Topology FourierTransform SchwartzMap

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (n : ℕ) : hermiteBasis n = hermiteLp n := by

  rw [hermiteBasis, HilbertBasis.coe_mk]
