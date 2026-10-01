-- Generated from ChapterHermiteFunctions.lean — solution of BookProof.HermiteCore.hasDerivAt_gaussH
import Mathlib
import Definitions.Def_ChapterHermiteFunctions
open BookProof.HermiteCore




open MeasureTheory Polynomial Filter Topology FourierTransform SchwartzMap

noncomputable section

set_option maxHeartbeats 1000000 in
t 2
    convert h0 using 1
    ring
  show HasDerivAt (fun y : ℝ => Real.exp ( :=
  -y ^ 2 / 2)) (-x * Real.exp (-x ^ 2 / 2)) x
    simpa [mul_comm] using h.exp
  
  theorem hasDerivAt_gaussH (x : ℝ) : HasDerivAt gaussH (-(x / 2) * gaussH x) x := by
    have h : HasDerivAt (fun y : ℝ =>
