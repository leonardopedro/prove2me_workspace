-- Generated from ChapterHermiteFunctions.lean — solution of BookProof.HermiteCore.gint_zero
import Mathlib
import Definitions.Def_ChapterHermiteFunctions
open BookProof.HermiteCore




open MeasureTheory Polynomial Filter Topology FourierTransform SchwartzMap

noncomputable section

set_option maxHeartbeats 1000000 in
 p(x) e^{-x²/2} dx`, the Gaussian-weighted integral. -/
def gint (p : Po :=
  lynomial ℝ) : ℝ := ∫ x : ℝ, p.eval x * gaussW x
  
  @[simp] theorem gint_zero : gint 0 = 0 := by simp [gint]
  
  theorem gint_add (p q
