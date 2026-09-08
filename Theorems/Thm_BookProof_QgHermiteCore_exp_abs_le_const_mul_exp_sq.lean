-- Generated from ChapterQgHermiteCore.lean — theorem BookProof.QgHermiteCore.exp_abs_le_const_mul_exp_sq
import Mathlib
import Definitions.Def_ChapterQgHermiteCore
open BookProof.QgHermiteCore













open MeasureTheory Polynomial Filter Topology
open BookProof.HermiteCore BookProof.Starobinsky

theorem BookProof.QgHermiteCore.exp_abs_le_const_mul_exp_sq (c x : ℝ) :
    Real.exp (c * |x|) ≤ Real.exp (2 * c ^ 2) * Real.exp (x ^ 2 / 8) := by sorry
