-- Generated from ChapterQgHermiteCore.lean — solution of BookProof.QgHermiteCore.memLp_gaussPoly
import Mathlib
import Definitions.Def_ChapterQgHermiteCore
import Theorems.Thm_BookProof_HermiteCore_memLp_poly_mul_gaussH
open BookProof.QgHermiteCore




open MeasureTheory Polynomial Filter Topology
open BookProof.HermiteCore BookProof.Starobinsky

set_option maxHeartbeats 1000000 in
theorem solution (p : Polynomial ℝ) :
    MemLp (fun x : ℝ => ((gaussPoly p x : ℝ) : ℂ)) 2 (volume : Measure ℝ) := memLp_poly_mul_gaussH p
