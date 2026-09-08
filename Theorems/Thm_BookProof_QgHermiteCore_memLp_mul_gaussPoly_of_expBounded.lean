-- Generated from ChapterQgHermiteCore.lean — theorem BookProof.QgHermiteCore.memLp_mul_gaussPoly_of_expBounded
import Mathlib
import Definitions.Def_ChapterQgHermiteCore
open BookProof.QgHermiteCore













open MeasureTheory Polynomial Filter Topology
open BookProof.HermiteCore BookProof.Starobinsky







variable {E : Type*} [NormedAddCommGroup E]

theorem BookProof.QgHermiteCore.memLp_mul_gaussPoly_of_expBounded {W : ℝ → ℝ} (hW : Continuous W)
    (hWb : ExpBounded W) (p : Polynomial ℝ) :
    MemLp (fun x : ℝ => ((W x * gaussPoly p x : ℝ) : ℂ)) 2 (volume : Measure ℝ) := by sorry
