-- Generated from ChapterQgHermiteCore.lean — theorem BookProof.QgHermiteCore.exp_abs_mul_gaussH_le
import Mathlib
import Definitions.Def_ChapterQgHermiteCore
open BookProof.QgHermiteCore













open MeasureTheory Polynomial Filter Topology
open BookProof.HermiteCore BookProof.Starobinsky

theorem BookProof.QgHermiteCore.exp_abs_mul_gaussH_le (c x : ℝ) :
    Real.exp (c * |x|) * gaussH x ≤ Real.exp (2 * c ^ 2) * Real.exp (-x ^ 2 / 8) := by sorry
