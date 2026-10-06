-- Generated from ChapterEulerDensityMatrix.lean — theorem BookProof.ChapterEulerDensityMatrix.euler_rhs
import Mathlib
import Definitions.Def_ChapterEulerDensityMatrix
open BookProof.ChapterEulerDensityMatrix


open scoped Matrix

theorem BookProof.ChapterEulerDensityMatrix.euler_rhs (t : ℝ) :
    (1 / 2 : ℝ) • (1 : Matrix (Fin 2) (Fin 2) ℝ)
        + Zdiag * ((Real.cos (2 * t)) • (1 : Matrix (Fin 2) (Fin 2) ℝ)
            + (Real.sin (2 * t)) • Jdens)
      = !![1 / 2 + Real.cos (2 * t) / 2, Real.sin (2 * t) / 2;
           Real.sin (2 * t) / 2, 1 / 2 - Real.cos (2 * t) / 2] := by sorry
