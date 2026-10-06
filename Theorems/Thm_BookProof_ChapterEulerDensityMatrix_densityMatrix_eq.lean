-- Generated from ChapterEulerDensityMatrix.lean — theorem BookProof.ChapterEulerDensityMatrix.densityMatrix_eq
import Mathlib
import Definitions.Def_ChapterEulerDensityMatrix
open BookProof.ChapterEulerDensityMatrix


open scoped Matrix

theorem BookProof.ChapterEulerDensityMatrix.densityMatrix_eq (t : ℝ) :
    densityMatrix t =
      !![Real.cos t ^ 2, Real.cos t * Real.sin t;
         Real.cos t * Real.sin t, Real.sin t ^ 2] := by sorry
