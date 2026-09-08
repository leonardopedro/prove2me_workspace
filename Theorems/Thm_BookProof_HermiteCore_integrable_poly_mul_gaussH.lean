-- Generated from ChapterHermiteFunctions.lean — theorem BookProof.HermiteCore.integrable_poly_mul_gaussH
import Mathlib
import Definitions.Def_ChapterHermiteFunctions
open BookProof.HermiteCore








open MeasureTheory Polynomial Filter Topology FourierTransform SchwartzMap

noncomputable section

theorem BookProof.HermiteCore.integrable_poly_mul_gaussH (p : Polynomial ℝ) :
    Integrable (fun x : ℝ => p.eval x * gaussH x) := by sorry
