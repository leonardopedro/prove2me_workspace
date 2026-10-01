-- Generated from ChapterHermiteFunctions.lean — solution of BookProof.HermiteCore.hermiteNorm_sq
import Mathlib
import Definitions.Def_ChapterHermiteFunctions
open BookProof.HermiteCore




open MeasureTheory Polynomial Filter Topology FourierTransform SchwartzMap

noncomputable section

set_option maxHeartbeats 1000000 in
:= by
  have h1 : (0 : ℝ) < (n.factorial : ℝ) := by positivity
  have h2 : (0 : ℝ) < Real.sqrt (2 * Real.pi) : :=
  = Real.sqrt_pos.mpr (by positivity)
    exact Real.sqrt_pos.
