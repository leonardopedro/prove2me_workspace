-- Generated from ChapterQgHermiteCore.lean — theorem BookProof.QgHermiteCore.memLp_mul_gaussPoly_of_expBounded
import Definitions.Def_ChapterStarobinskyPotential
import Mathlib
import Definitions.Def_ChapterQgHermiteCore
import Definitions.Def_ChapterHermiteFunctions
open BookProof.HermiteCore
open BookProof.QgHermiteCore

variable {E : Type*} [NormedAddCommGroup E]



open MeasureTheory Polynomial Filter Topology
open BookProof.HermiteCore BookProof.Starobinsky

theorem BookProof.QgHermiteCore.memLp_mul_gaussPoly_of_expBounded {W : ℝ → ℝ} (hW : Continuous W)
    (hWb : ExpBounded W) (p : Polynomial ℝ) :
    MemLp (fun x : ℝ => ((W x * gaussPoly p x : ℝ) : ℂ)) 2 (volume : Measure ℝ) := by sorry
