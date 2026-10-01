-- Generated from ChapterQgHermiteCore.lean — theorem BookProof.QgHermiteCore.memLp_gaussPoly
import Definitions.Def_ChapterStarobinskyPotential
import Mathlib
import Definitions.Def_ChapterQgHermiteCore
import Definitions.Def_ChapterHermiteFunctions
open BookProof.HermiteCore
open BookProof.QgHermiteCore

variable {E : Type*} [NormedAddCommGroup E]
variable {d : ℕ}



open MeasureTheory Polynomial Filter Topology
open BookProof.HermiteCore BookProof.Starobinsky

theorem BookProof.QgHermiteCore.memLp_gaussPoly (p : Polynomial ℝ) :
    MemLp (fun x : ℝ => ((gaussPoly p x : ℝ) : ℂ)) 2 (volume : Measure ℝ) := by sorry
