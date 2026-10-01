-- Generated from ChapterQgHermiteCore.lean — theorem BookProof.QgHermiteCore.memLp_abs_poly_mul_exp_neg_eighth
import Definitions.Def_ChapterStarobinskyPotential
import Mathlib
import Definitions.Def_ChapterQgHermiteCore
import Definitions.Def_ChapterHermiteFunctions
open BookProof.HermiteCore
open BookProof.QgHermiteCore

variable {E : Type*} [NormedAddCommGroup E]



open MeasureTheory Polynomial Filter Topology
open BookProof.HermiteCore BookProof.Starobinsky

theorem BookProof.QgHermiteCore.memLp_abs_poly_mul_exp_neg_eighth (p : Polynomial ℝ) :
    MemLp (fun x : ℝ => ((|p.eval x| * Real.exp (-x ^ 2 / 8) : ℝ) : ℂ)) 2
      (volume : Measure ℝ) := by sorry
