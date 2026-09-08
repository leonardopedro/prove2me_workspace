-- Generated from ChapterQgHermiteCore.lean — theorem BookProof.QgHermiteCore.integrable_potential_gaussPoly_mul
import Mathlib
import Definitions.Def_ChapterQgHermiteCore
open BookProof.QgHermiteCore













open MeasureTheory Polynomial Filter Topology
open BookProof.HermiteCore BookProof.Starobinsky







variable {E : Type*} [NormedAddCommGroup E]

theorem BookProof.QgHermiteCore.integrable_potential_gaussPoly_mul {W : ℝ → ℝ} (hW : Continuous W)
    (hWb : ExpBounded W) (p q : Polynomial ℝ) :
    Integrable (fun x : ℝ => W x * (gaussPoly p x * gaussPoly q x)) := by sorry
