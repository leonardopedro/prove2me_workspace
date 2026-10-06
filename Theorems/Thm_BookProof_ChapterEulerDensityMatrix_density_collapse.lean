-- Generated from ChapterEulerDensityMatrix.lean — theorem BookProof.ChapterEulerDensityMatrix.density_collapse
import Mathlib
import Definitions.Def_ChapterEulerDensityMatrix
open BookProof.ChapterEulerDensityMatrix


open scoped Matrix

theorem BookProof.ChapterEulerDensityMatrix.density_collapse (t : ℝ) :
    densityMatrix t - (Real.sin (2 * t)) • (Zdiag * Jdens)
      = !![Real.cos t ^ 2, 0; 0, Real.sin t ^ 2] := by sorry
