-- Generated from ChapterQgHermiteCore.lean — theorem BookProof.QgHermiteCore.memLp_starobinskyV_mul_gaussPoly
import Definitions.Def_ChapterHermiteFunctions
import Mathlib
import Definitions.Def_ChapterQgHermiteCore
import Definitions.Def_ChapterStarobinskyPotential
open BookProof.Starobinsky
open BookProof.QgHermiteCore

variable {E : Type*} [NormedAddCommGroup E]
variable {d : ℕ}



open MeasureTheory Polynomial Filter Topology
open BookProof.HermiteCore BookProof.Starobinsky

theorem BookProof.QgHermiteCore.memLp_starobinskyV_mul_gaussPoly (M alpha : ℝ) (hM : 0 < M) (p : Polynomial ℝ) :
    MemLp (fun x : ℝ => ((starobinskyV M alpha x * gaussPoly p x : ℝ) : ℂ)) 2
      (volume : Measure ℝ) := by sorry
