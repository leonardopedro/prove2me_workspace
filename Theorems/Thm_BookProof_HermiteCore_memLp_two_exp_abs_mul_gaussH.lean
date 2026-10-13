-- Generated from ChapterHermiteFunctions.lean — theorem BookProof.HermiteCore.memLp_two_exp_abs_mul_gaussH
import Mathlib
import Definitions.Def_ChapterHermiteFunctions
open BookProof.HermiteCore



open MeasureTheory Polynomial Filter Topology FourierTransform SchwartzMap

noncomputable section

theorem BookProof.HermiteCore.memLp_two_exp_abs_mul_gaussH (c : ℝ) :
    MemLp (fun x : ℝ => ((Real.exp (c * |x|) * gaussH x : ℝ) : ℂ)) 2 (volume : Measure ℝ) := by sorry
