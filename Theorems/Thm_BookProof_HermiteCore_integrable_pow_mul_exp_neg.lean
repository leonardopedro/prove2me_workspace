-- Generated from ChapterHermiteFunctions.lean — theorem BookProof.HermiteCore.integrable_pow_mul_exp_neg
import Mathlib
import Definitions.Def_ChapterHermiteFunctions
open BookProof.HermiteCore



open MeasureTheory Polynomial Filter Topology FourierTransform SchwartzMap

noncomputable section

theorem BookProof.HermiteCore.integrable_pow_mul_exp_neg (k : ℕ) {b : ℝ} (hb : 0 < b) :
    Integrable (fun x : ℝ => x ^ k * Real.exp (-b * x ^ 2)) := by sorry
