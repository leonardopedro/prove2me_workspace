-- Generated from ChapterQgHermiteCore.lean — theorem BookProof.QgHermiteCore.expBounded_poly
import Mathlib
import Definitions.Def_ChapterQgHermiteCore
open BookProof.QgHermiteCore













open MeasureTheory Polynomial Filter Topology
open BookProof.HermiteCore BookProof.Starobinsky







variable {E : Type*} [NormedAddCommGroup E]

theorem BookProof.QgHermiteCore.expBounded_poly (p : Polynomial ℝ) : ExpBounded (fun x => p.eval x) := by sorry
