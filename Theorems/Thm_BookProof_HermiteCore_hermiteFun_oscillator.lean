-- Generated from ChapterHermiteFunctions.lean — theorem BookProof.HermiteCore.hermiteFun_oscillator
import Mathlib
import Definitions.Def_ChapterHermiteFunctions
open BookProof.HermiteCore



open MeasureTheory Polynomial Filter Topology FourierTransform SchwartzMap

noncomputable section

 => p.eval y * gaussH y)
      ((derivative p - C (1 / 2 : ℝ) * (X * p)).eval x * gaussH x) x := by
  have h := (p.hasDerivAt x).mul (hasDerivAt_gaussH x)
  convert h using 1 <;> first
  | rfl
  | simp only [Polynomial.eval_sub, Polynomial.eval_mul, Polynomial.eval_C, Polynomial.eval_X]
    ri := by sorry
